Return-Path: <linux-kernel+bounces-526329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F37A3FD47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A45425D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4A2500BA;
	Fri, 21 Feb 2025 17:20:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F724FC0D;
	Fri, 21 Feb 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158430; cv=none; b=QRLTcy5yFvUOLkT0PAJnomHbUppmZwlTmalWe6ZcK118g5LjdmBO6SjPoXW95FDspKUFIXSbiWDDCsWbptUH+fGvNAJxH39oXO41sz+jd0VOy7mkZuYVONjNUsDFbHjMiDxneMWGF3pSYPDE/IePE+pLPenJHP5igFchQ6GxldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158430; c=relaxed/simple;
	bh=kJdUYKR/ptSnTrVPpsg+chFzKmKJQnRwk0j4IPeq6OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH6rjESUaV5I+NagQ8rxltDE8urJjmhutYMUoGPrp68xTJn+//kfnuV+fe5jIslT2IIVhhQbo8eVc6pG5YlDvGR2/EnoVEKWnNs0iTGYB1UnlwyalkPed/1Xc1BniddMMS/odQK/4RDtwUjgbkwFDBiueEvnWafY+mXxIgLhXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C61168F;
	Fri, 21 Feb 2025 09:20:44 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39BA13F5A1;
	Fri, 21 Feb 2025 09:20:26 -0800 (PST)
Message-ID: <b940bd7e-ed9b-4ade-9bd3-1de8cdae5d8f@arm.com>
Date: Fri, 21 Feb 2025 17:20:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] xlnx: dt-bindings: Convert to json-schema
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

Since I did not hear from Srinivas for more then two months, I am going to post
the following addition to the MAINTAINERS file as part of my next re-spin of
this series later today:

+XILINX SOUND DRIVERS
+M:     Vincenzo Frascino <vincenzo.frascino@arm.com>
+S:     Maintained
+F:     Documentation/devicetree/bindings/sound/xlnx,i2s.txt
+F:     Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
+F:     Documentation/devicetree/bindings/sound/xlnx,spdif.txt
+F:     sound/soc/xilinx/*

Please let me know if there is any concern with it.

Thanks and Regards,
Vincenzo

On 13/12/2024 16:52, Vincenzo Frascino wrote:
> This series converts the folling Xilinx device tree binding documentation:
>  - xlnx,i2s
>  - xlnx,audio-formatter
>  - xlnx,spdif
> to json-schema.
> 
> To simplify the testing a linux tree rebased on 6.13-rc1 is accessible
> at [1].
> 
> [1] https://codeberg.org/vincenzo/linux/src/branch/xlnx/dt-bindings/v1
> 
> Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Vincenzo Frascino (3):
>   xlnx: dt-bindings: xlnx,i2s: Convert to json-schema
>   xlnx: dt-bindings: xlnx,audio-formatter: Convert to json-schema
>   xlnx: dt-bindings: xlnx,spdif: Convert to json-schema
> 
>  .../bindings/sound/xlnx,audio-formatter.txt   |  29 -----
>  .../bindings/sound/xlnx,audio-formatter.yaml  |  84 +++++++++++++++
>  .../devicetree/bindings/sound/xlnx,i2s.txt    |  28 -----
>  .../devicetree/bindings/sound/xlnx,i2s.yaml   |  79 ++++++++++++++
>  .../devicetree/bindings/sound/xlnx,spdif.txt  |  28 -----
>  .../devicetree/bindings/sound/xlnx,spdif.yaml | 100 ++++++++++++++++++
>  6 files changed, 263 insertions(+), 85 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> 

-- 
Regards,
Vincenzo


