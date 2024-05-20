Return-Path: <linux-kernel+bounces-183664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E08C9C38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D461B228FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EFF53E05;
	Mon, 20 May 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4+3RMy1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DE537F1;
	Mon, 20 May 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205215; cv=none; b=qRhXnHjUXY8gEbmfUoa42p046nfn8mjAeu6Vc6xVv3ojpNVGE794Uq+xcZmCVQosgfGU8yKjRhjVB2gefYFp/kqJp41d8ERRFKtjZjTmVCztrmqxJ/h3d0IX4uagF0MqyOqjXzrA4HBfhTU100DnqJrOiEM5q5s2Eu3pj8BsM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205215; c=relaxed/simple;
	bh=1ZD03fMcALKDBBWPizlRTyNCf7k3HihvvnLuyUfqcV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQy8F/JXM+4TahftXrZX8+sGTMfejsmUYqMXUdddVp2VR1nyQ6Hv83uFCTO5pHCi9kod86iLaAb6JcqZfu87vxnVufxvS4vtbAP2Id3gwbZcdkGZHYGRcvHiRO862Gnkani70nEEDfvoenSvbGEMmpJxAIciiFYEiq9mZZv4fMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4+3RMy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9F2C2BD10;
	Mon, 20 May 2024 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716205214;
	bh=1ZD03fMcALKDBBWPizlRTyNCf7k3HihvvnLuyUfqcV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V4+3RMy1rAVVDSgzYXDe66IVunUIYaThDXh2M6ZNx6vi1JHSV1wULoIQxY4thVFVZ
	 JcW4PH9TS9wqnv3wKMWZbMl2Fz297wRMxL4JwE5MqbleIykw3rR81jZbxHF5ThjV1c
	 RqYrReZG8mhH2a7lFAaJjsyHIQZB0c+dkyovWJ1ZYtw7JX1VdaKaCNnFQKmPwgMWDM
	 nhneyn80voAbZr+G/3rHKUolSrEpY4PO/KwIY7MrR3wY6xiK74WXok45mIbsrh1Iww
	 NXbgiiryvQ9tXwr0FQKPwGqPnogjOrZ6HOMy1IjZRS34FFCTDXcaiV3ihMwXJUJ8rQ
	 /b4HQBQchpzyA==
Message-ID: <f1e1cc23-5fb4-4b18-9bfb-4a08be728924@kernel.org>
Date: Mon, 20 May 2024 14:40:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: ti: k3-am65-mcu: add dedicated wakeup
 controller compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <20240518-dt-bindings-ti-soc-mfd-v1-4-b3952f104c9a@linaro.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-4-b3952f104c9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/05/2024 23:07, Krzysztof Kozlowski wrote:
> Each syscon node must come with a dedicated/specific compatible, which
> is also reported by dtbs_check:
> 
>   k3-am654-base-board.dtb: scm-conf@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
> 
> Add one for the TI K3 AM654 MCU wakeup system controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

