Return-Path: <linux-kernel+bounces-181847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF058C824C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C97FB23600
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0629CE3;
	Fri, 17 May 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuXDHiIe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754241C6AD;
	Fri, 17 May 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933071; cv=none; b=G+OQFoEFxrnEgF57/sb78b92pvHaUXazJaBVmfIxHeGiu1u6f1uCwcKaAQVb1MKBdxNLMpnBEXU5iGM1GSeB2YsOTblzK18jj7jbqouinE4hM/+p37M681BH165h03mqGK4/p8XzTNdHP4vIPSrl+gOpv4s35+RsdvB7IRLWRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933071; c=relaxed/simple;
	bh=ZVzrf5p+vERgu2yeNVu4eeDTooUlWW7SEbRAs2XGLqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDLXghu75MqiMZk1V9Fijbbrzota7lrNG9Z9lIYrjRgE40b2IU0w2j1gIEIvpMcXQLz5noMs4CnY2E+LPawoMjY0hmBctHxJ7s8dRcUwDzyfwABv33xwLFpgxHMaB25vopNgqUfiENpOPQzjNiPF3QEhwq0W1Sr8YTDBvLAmBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuXDHiIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252F1C32782;
	Fri, 17 May 2024 08:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715933070;
	bh=ZVzrf5p+vERgu2yeNVu4eeDTooUlWW7SEbRAs2XGLqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JuXDHiIeyIVNtbOimvi7YxGsP0aqDzMXTQXxVnMMioO5/Hs0/U2Far31nMxKLr1Z/
	 bFiCQzb/D+G6iWjYUMFX0VMubkjQDOIpNSDbVTJptBU1eMWo1K80GPBFEmpoXIm21W
	 /otFFPIo/brbII2dzN20chepE33sLEk6hH1uZRt99Mmx8iwQDHLioAWQzHyag7kKJO
	 Evx5l19VkRJWlms6ZhZ3FjRccgecjE5n9trj9gjQx/5wHQyKv2XdhNUPzc5yF+J9xI
	 FAVZ5w97iNXIdOSiJoBI6mxXditvam7e1i6JqexnqCDLaWG2r9T9sX4vcFF9apeEi5
	 eSe1oRwgveQNw==
Message-ID: <355b7e72-edbb-4d2e-b22f-1c8b21fe07b0@kernel.org>
Date: Fri, 17 May 2024 11:04:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: ti: Update maintainers list
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, s-vadapalli@ti.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240516054932.27597-1-r-gunasekaran@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240516054932.27597-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/05/2024 08:49, Ravi Gunasekaran wrote:
> Update the list with the current maintainers of TI's CPSW ethernet
> peripheral.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

--
cheers,
-roger

