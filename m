Return-Path: <linux-kernel+bounces-308734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A961E96610A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352B928793C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CF19992E;
	Fri, 30 Aug 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdFPeWyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE2192D60;
	Fri, 30 Aug 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018778; cv=none; b=umJmhnpVm80JTaFU5A+Qt5L49O4bxlCNyXIgiC/PhPVFp4X4P8E8Pv7a6iJi/UbnuzIiReIuZXnmZ7r5PEwfDCmMLTzba5NH6Hs6MuYCA+fF7X/4q5vJz1IifvAPfl1ouOM74kf5iUlx74lDDY2lhw+E8ycLl8UJKjygGarIENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018778; c=relaxed/simple;
	bh=56tTdgtjIlTW2efJuFIybkv5go51PKecOfCa71iQCug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MONenWJ9RX+r848oygsXsh4BCG1n3Y7jpicuBv52iNbstMHZahj7+KfMS49bqDIgUihho6aCHfH+G+SXgbwFpUgwg8TZrvbTXuG+/zxBcBHErUNePf9sBZwxPSccSd0NK9tS2DveLMJwrfAKghlWIBPvoORaLymtTnWyxFxUPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdFPeWyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ED4C4CEC2;
	Fri, 30 Aug 2024 11:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725018777;
	bh=56tTdgtjIlTW2efJuFIybkv5go51PKecOfCa71iQCug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LdFPeWyP1bLB+ZsQrZjlWXNUOABzyXiZx7Ki9shqYhsYS+Zqapuj4q9h7+CRpkKXD
	 dZKiUoQk7zA8FrvU0kqq3SX/t6rqv/Df2Tkbjy1CjknQaYP2ugRX49acAAY6yUZnGr
	 54t7MxqjPAwPM7x9iyuHPp/iaaNkwbCH1z6LN9wqkylwrOM5t06hLGCEb4MmBwktnh
	 XvqvoRk1n/xV34ukDPUP34kqWFXV7rh/tJMx0UdSApSOlto3xtPzWRjTsB22ZWshpk
	 ONDxhAIj3LLYEYXLG8INL+t50BJFkVuMuQWrTf6svsXj+SmWwncG7CD85mf/1xIKMi
	 Gc2gMdfPIgMVw==
Message-ID: <bd9a3164-bc32-48d4-a5e2-af267fc48992@kernel.org>
Date: Fri, 30 Aug 2024 14:52:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am654-idk: Fix dtbs_check warning in
 ICSSG dmas
To: MD Danish Anwar <danishanwar@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Tero Kristo <kristo@kernel.org>,
 srk@ti.com
References: <20240830111000.232028-1-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240830111000.232028-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/2024 14:10, MD Danish Anwar wrote:
> ICSSG doesn't use mgmnt rsp dmas. But these are added in the dmas for
> icssg1-eth and icssg0-eth node.
> 
> These mgmnt rsp dmas result in below dtbs_check warnings.
> 
> /workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg1-eth: dmas: [[39, 49664], [39, 49665], [39, 49666], [39, 49667], [39, 49668], [39, 49669], [39, 49670], [39, 49671], [39, 16896], [39, 16897], [39, 16898], [39, 16899]] is too long
> 	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
> /workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg0-eth: dmas: [[39, 49408], [39, 49409], [39, 49410], [39, 49411], [39, 49412], [39, 49413], [39, 49414], [39, 49415], [39, 16640], [39, 16641], [39, 16642], [39, 16643]] is too long
> 	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
> 
> Fix these warnings by removing mgmnt rsp dmas from icssg1-eth and
> icssg0-eth nodes.
> 
> Fixes: a4d5bc3214eb ("arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet ports")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

