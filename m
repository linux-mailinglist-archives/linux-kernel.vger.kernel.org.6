Return-Path: <linux-kernel+bounces-514535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8464CA35835
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB3C1891BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2521CA08;
	Fri, 14 Feb 2025 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n2OO5nx/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612B20C038
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519619; cv=none; b=HvzwL9IUoOpYoVXZuE0rgQUqlSEGrhv8+aJhcJnMPlGlq11BgqJRxRVz3gywgi5FSOLRm2MGAkODo5PxCTQvz6S8aUXOHjKLO3I6Szu6hBJAw6Ctj6upwrHoNmF0u9kW7HxZbZkcSbuC7ZLrHm68aRNpp8Ef9qAyClY+5oSkmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519619; c=relaxed/simple;
	bh=zxd7MqrUFbwoKk31uJkFvKgEBdNn3QGkrLKashAh8HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqsl96junydfBf74SUrNiOPyX1u4GpFSR6Q0A/Ojww+qTUc1gqQV/pCfKcnUaolkH9vgD8MF62O25BTda+Lz7KLPiTUDGfnjwbzNwMgBYzMN/GKacyzmb6zSricXnFg1aBcQZRXT6xT47AN/EPawGF29bUdOKSn8+ccIk7Ja7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n2OO5nx/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739519615;
	bh=zxd7MqrUFbwoKk31uJkFvKgEBdNn3QGkrLKashAh8HA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n2OO5nx/XuislDMe7yVKfiSyUNiY8mY3ItvADBcPtXYsMAl/wY02LjNyQuExuL4xC
	 elS4VX99PbewQ8D0yqzp3lP9/chJVlmZHPqzrzOSx/bpVr2Yj5FaG8YsNIEWIUTKfw
	 4ThkYuDdVrx6nLZyTQpDrq3gh2hhOOt9jemtlMgqdLEsLilD1r+CKiOiTDenhoXREp
	 fSb6Xl9hMb270f5uSTPcu5xJ/ynoi2UezXpt1BhwjZOX98DF1DnDT/XE/2D9P44DtL
	 C9klEWpmxnNsK2T6eKxELqmroyil31FNIU3aCKroeZYJ1pkKbGMi66yLFysBQdSdNQ
	 QqO2DvDVJuORw==
Received: from [192.168.50.250] (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 868B017E0860;
	Fri, 14 Feb 2025 08:53:30 +0100 (CET)
Message-ID: <5e5ecd07-9932-4f5e-ba7a-49fbea9edd84@collabora.com>
Date: Fri, 14 Feb 2025 13:22:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/ci: enable lockdep detection
To: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 airlied@gmail.com, simona.vetter@ffwll.ch, robdclark@gmail.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, jani.nikula@linux.intel.com,
 dmitry.baryshkov@linaro.org, mripard@kernel.org, boqun.feng@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250211152812.54018-1-vignesh.raman@collabora.com>
 <20250211152812.54018-4-vignesh.raman@collabora.com>
 <CAPW4XYZtj7HRhoeOfYguZBEnbqpbRscKrXTn5821aAxvcqNb0g@mail.gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPW4XYZtj7HRhoeOfYguZBEnbqpbRscKrXTn5821aAxvcqNb0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helen,

On 13/02/25 18:13, Helen Mae Koike Fornazier wrote:
> Hi Vignesh,
> 
> thanks for your patch.
> 
> Em ter., 11 de fev. de 2025 às 12:29, Vignesh Raman
> <vignesh.raman@collabora.com> escreveu:
>>
>> We have enabled PROVE_LOCKING (which enables LOCKDEP) in drm-ci.
>> This will output warnings when kernel locking errors are encountered
>> and will continue executing tests. To detect if lockdep has been
>> triggered, check the debug_locks value in /proc/lockdep_stats after
>> the tests have run. When debug_locks is 0, it indicates that lockdep
>> has detected issues and turned itself off. Check this value, and if
>> lockdep is detected, exit with an error and configure it as a warning
>> in GitLab CI.
>>
>> GitLab CI ignores exit codes other than 1 by default. Pass the correct
>> exit code with variable FF_USE_NEW_BASH_EVAL_STRATEGY set to true or
>> exit on failure.
>>
>> Also update the documentation.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> v2:
>>    - Lockdep failures are reported as pipeline warnings,
>>      and the documentation is updated.
>>
>> ---
>>   Documentation/gpu/automated_testing.rst |  4 ++++
>>   drivers/gpu/drm/ci/igt_runner.sh        | 11 +++++++++++
>>   drivers/gpu/drm/ci/test.yml             | 19 ++++++++++++++++---
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
>> index 6d7c6086034d..62aa3ede02a5 100644
>> --- a/Documentation/gpu/automated_testing.rst
>> +++ b/Documentation/gpu/automated_testing.rst
>> @@ -115,6 +115,10 @@ created (eg. https://gitlab.freedesktop.org/janedoe/linux/-/pipelines)
>>   5. The various jobs will be run and when the pipeline is finished, all jobs
>>   should be green unless a regression has been found.
>>
>> +6. Warnings in the pipeline indicate that lockdep
>> +(see Documentation/locking/lockdep-design.rst) issues have been detected
>> +during the tests.
>> +
>>
>>   How to update test expectations
>>   ===============================
>> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
>> index 68b042e43b7f..2a0599f12c58 100755
>> --- a/drivers/gpu/drm/ci/igt_runner.sh
>> +++ b/drivers/gpu/drm/ci/igt_runner.sh
>> @@ -85,5 +85,16 @@ deqp-runner junit \
>>      --limit 50 \
>>      --template "See $ARTIFACTS_BASE_URL/results/{{testcase}}.xml"
>>
>> +# Check if /proc/lockdep_stats exists
>> +if [ -f /proc/lockdep_stats ]; then
>> +    # If debug_locks is 0, it indicates lockdep is detected and it turns itself off.
>> +    debug_locks=$(grep 'debug_locks:' /proc/lockdep_stats | awk '{print $2}')
>> +    if [ "$debug_locks" -eq 0 ] && [ "$ret" -eq 0 ]; then
>> +        echo "Warning: LOCKDEP issue detected. Please check dmesg logs for more information."
>> +        cat /proc/lockdep_stats
>> +        ret=101
>> +    fi
>> +fi
>> +
>>   cd $oldpath
>>   exit $ret
>> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
>> index 0eab020a33b9..3af735dbf6bd 100644
>> --- a/drivers/gpu/drm/ci/test.yml
>> +++ b/drivers/gpu/drm/ci/test.yml
>> @@ -1,6 +1,8 @@
>>   .lava-test:
>>     extends:
>>       - .container+build-rules
>> +  variables:
>> +    FF_USE_NEW_BASH_EVAL_STRATEGY: 'true'
>>     timeout: "1h30m"
>>     rules:
>>       - !reference [.scheduled_pipeline-rules, rules]
>> @@ -13,6 +15,9 @@
>>       - mv -n install/* artifacts/.
>>       # Override it with our lava-submit.sh script
>>       - ./artifacts/lava-submit.sh
>> +  allow_failure:
>> +    exit_codes:
>> +      - 101
> 
> Maybe we could have this rule more generically instead of just in lava,
> so we can re-use it in other jobs as well and we don't need to repeat it.

Yes agreed. I will post a patch with this update.

Regards,
Vignesh

> 
> 
> Regards,
> Helen
> 
>>
>>   .lava-igt:arm32:
>>     extends:
>> @@ -88,9 +93,14 @@
>>       - igt:arm64
>>     tags:
>>       - $RUNNER_TAG
>> +  allow_failure:
>> +    exit_codes:
>> +      - 101
>>
>>   .software-driver:
>>     stage: software-driver
>> +  variables:
>> +    FF_USE_NEW_BASH_EVAL_STRATEGY: 'true'
>>     timeout: "1h30m"
>>     rules:
>>       - !reference [.scheduled_pipeline-rules, rules]
>> @@ -108,6 +118,9 @@
>>       - debian/x86_64_test-gl
>>       - testing:x86_64
>>       - igt:x86_64
>> +  allow_failure:
>> +    exit_codes:
>> +      - 101
>>
>>   .msm-sc7180:
>>     extends:
>> @@ -153,7 +166,7 @@ msm:apq8016:
>>       BM_KERNEL_EXTRA_ARGS: clk_ignore_unused
>>       RUNNER_TAG: google-freedreno-db410c
>>     script:
>> -    - ./install/bare-metal/fastboot.sh
>> +    - ./install/bare-metal/fastboot.sh || exit $?
>>
>>   msm:apq8096:
>>     extends:
>> @@ -167,7 +180,7 @@ msm:apq8096:
>>       GPU_VERSION: apq8096
>>       RUNNER_TAG: google-freedreno-db820c
>>     script:
>> -    - ./install/bare-metal/fastboot.sh
>> +    - ./install/bare-metal/fastboot.sh || exit $?
>>
>>   msm:sdm845:
>>     extends:
>> @@ -181,7 +194,7 @@ msm:sdm845:
>>       GPU_VERSION: sdm845
>>       RUNNER_TAG: google-freedreno-cheza
>>     script:
>> -    - ./install/bare-metal/cros-servo.sh
>> +    - ./install/bare-metal/cros-servo.sh || exit $?
>>
>>   msm:sm8350-hdk:
>>     extends:
>> --
>> 2.43.0
>>
> 
> 

