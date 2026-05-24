#!/usr/bin/env raku

sub fam(Str $id, Str $renderer, Str $tranche, Str $context-key, Str $context-value) {
    %( id => $id, renderer => $renderer, tranche => $tranche, context-key => $context-key, context-value => $context-value )
}

my @families =
    fam('code_analyzer', 'classic-six.code_analyzer', 'classic-six', 'analysisFocus', 'grammar-action-audit'),
    fam('data_processing', 'classic-six.data_processing', 'classic-six', 'dataWindow', 'sequence-stream-reconciliation'),
    fam('jargon', 'classic-six.jargon', 'classic-six', 'languagePolicy', 'raku-glossary'),
    fam('metrics', 'classic-six.metrics', 'classic-six', 'signalBlend', 'multi-dispatch-runtime-latency'),
    fam('network_activity', 'classic-six.network_activity', 'classic-six', 'transportMix', 'socket-http-sse'),
    fam('system_monitoring', 'classic-six.system_monitoring', 'classic-six', 'telemetryScope', 'rakudo-moarvm-runtime-host'),
    fam('agent_workflows', 'modern-core.agent_workflows', 'modern-core', 'coordinationMode', 'supply-dispatch-handshake'),
    fam('platform_engineering', 'modern-core.platform_engineering', 'modern-core', 'platformSurface', 'rakudo-native-validation-lane'),
    fam('observability_ai_runtime', 'modern-core.observability_ai_runtime', 'modern-core', 'runtimeSignals', 'logs-metrics-provider-boundary'),
    fam('delivery_preview_ops', 'modern-core.delivery_preview_ops', 'modern-core', 'deliveryGuardrail', 'script-preview-checkpoints'),
    fam('supply_chain_security', 'modern-core.supply_chain_security', 'modern-core', 'supplyChainPosture', 'source-script-attestation'),
    |('ai_inference_ops evaluation_and_guardrails knowledge_retrieval edge_client_runtime identity_and_trust aibom_provenance agent_boundary_security embedded_agentic_pipeline data_governance_compliance finops_capacity'.words.map: { fam($_, 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance') }),
    |('blockchain_protocol_ops cross_chain_interop proof_and_sequencer_ops'.words.map: { fam($_, 'fallback.security_blockchain', 'fallback-security_blockchain', 'fallbackFamily', 'security_blockchain') }),
    |('hybrid_runtime_ops capacity_cost_controller batch_execution_tuner compiler_maintainer interop_adapter_engineer preflight_capacity_planner simulator_performance_engineer'.words.map: { fam($_, 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum') }),
    |('fhir_profile_generator smart_launch_oauth bulk_fhir_population_ops hl7v2_feed_ops clinical_workflow_events dicomweb_imaging_ops openehr_semantic_record_ops device_telemetry_clinical emr_vendor_adapter ocpp_chargepoint_ops ocpi_roaming_ops mcp_a2a_ops streaming_bus_ops service_mesh_rpc_ops'.words.map: { fam($_, 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol') });

sub registry-id(Str $value --> Str) { $value.trans('_' => '-') }
sub normalize-family(Str $value --> Str) { $value.lc.trans('-' => '_') }
sub find-family(Str $value) { @families.first(*<id> eq normalize-family($value)) }
sub deterministic-hash(Str $value --> UInt) { my UInt $hash = 2166136261; for $value.ords -> $code { $hash = ($hash * 16777619 + $code) % 4294967296 }; $hash }
sub pad2(Int $value --> Str) { $value < 10 ?? "0$value" !! ~$value }
sub quoted-ids(@items --> Str) { @items.map({ '"' ~ registry-id($_<id>) ~ '"' }).join(',') }

sub print-registry() {
    my @rows = @families.map: { '{"id":"' ~ $_<id> ~ '","registryId":"' ~ registry-id($_<id>) ~ '","rendererKey":"' ~ $_<renderer> ~ '","tranche":"' ~ $_<tranche> ~ '"}' };
    my @classic = @families.grep(*<tranche> eq 'classic-six');
    my @modern = @families.grep(*<tranche> eq 'modern-core');
    my @fallback = @families.grep({ $_<tranche> ne 'classic-six' && $_<tranche> ne 'modern-core' });
    say '{"outputFormats":["text","json"],"flags":["list-values","focus-family","output-format","seed","experimental-provider"],"generatorFamilies":[' ~ @rows.join(',') ~ '],"classicSix":[' ~ quoted-ids(@classic) ~ '],"modernCore":[' ~ quoted-ids(@modern) ~ '],"fallbackFamilies":[' ~ quoted-ids(@fallback) ~ '],"implementationMode":"family-focus-deterministic"}';
}

sub print-payload(%family, Str $seed, Str $output-format) {
    my UInt $hash = deterministic-hash($seed ~ '::' ~ %family<id>);
    my Int $seconds = $hash % 86400;
    my Int $hour = $seconds div 3600;
    my Int $minute = ($seconds % 3600) div 60;
    my Int $second = $seconds % 60;
    my Int $sequence = 1000 + ($hash % 9000);
    my Str $timestamp = '2026-01-01T' ~ pad2($hour) ~ ':' ~ pad2($minute) ~ ':' ~ pad2($second) ~ 'Z';
    my Str $fingerprint = registry-id(%family<id>) ~ '-' ~ $hash.base(16).lc;
    if $output-format eq 'json' {
        say '{"eventType":"stakeholder.generator.output","sequence":' ~ $sequence ~ ',"family":"' ~ %family<id> ~ '","message":"Deterministic raku tranche for ' ~ %family<id> ~ '","timestamp":"' ~ $timestamp ~ '","context":{"rendererKey":"' ~ %family<renderer> ~ '","' ~ %family<context-key> ~ '":"' ~ %family<context-value> ~ '","seedFingerprint":"' ~ $fingerprint ~ '","tranche":"' ~ %family<tranche> ~ '","rakuProfile":"rakudo-moarvm-hash-catalog"},"generationProvenance":{"sourceRepo":"raku-stakeholder","baseline":"local-small-tranche-family-focus","experimental":false,"adapterType":"static-hash-catalog","promptVersion":null},"outputFormat":"json"}';
    } else {
        say 'family: ' ~ %family<id>;
        say 'renderer: ' ~ %family<renderer>;
        say 'tranche: ' ~ %family<tranche>;
        say 'sequence: ' ~ $sequence;
        say 'timestamp: ' ~ $timestamp;
        say 'message: Deterministic raku tranche for ' ~ %family<id>;
    }
}

sub fail(Str $message) { note $message; exit 2 }
sub fail-with(Str $message, Str $value) { fail($message ~ ': ' ~ $value) }

my Str $focus-family = '';
my Str $seed = 'default-seed';
my Str $output-format = 'text';
my Bool $list-values = False;
my @args = @*ARGS;
my Int $i = 0;
while $i < @args.elems {
    given @args[$i] {
        when '--list-values' { $list-values = True; $i += 1 }
        when '--focus-family' { fail('missing value for --focus-family') if $i + 1 >= @args.elems; $focus-family = @args[$i + 1]; $i += 2 }
        when '--seed' { fail('missing value for --seed') if $i + 1 >= @args.elems; $seed = @args[$i + 1]; $i += 2 }
        when '--output-format' {
            fail('missing value for --output-format') if $i + 1 >= @args.elems;
            my $candidate = @args[$i + 1];
            fail-with('invalid --output-format', $candidate) unless $candidate eq 'text' || $candidate eq 'json';
            $output-format = $candidate;
            $i += 2;
        }
        when '--experimental-provider' { fail('missing value for --experimental-provider') if $i + 1 >= @args.elems; fail-with('experimental provider is not enabled in the deterministic first tranche', @args[$i + 1]) }
        default { fail('experimental flags require --experimental-provider') if @args[$i].starts-with('--experimental-'); fail-with('unknown argument', @args[$i]) }
    }
}

if $list-values { print-registry(); exit 0 }
fail('focus-family is required and must be a known generator family') if $focus-family eq '';
my $family = find-family($focus-family) // fail-with('invalid --focus-family', $focus-family);
print-payload($family, $seed, $output-format);
