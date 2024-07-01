Return-Path: <linux-kernel+bounces-236258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29F91DF96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C3B21E11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C25158D8E;
	Mon,  1 Jul 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trZIL0BK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03380155381;
	Mon,  1 Jul 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837695; cv=none; b=Ze1eu+8p8avzrm8Q+2ifLjMuuhvCH7px+rqHROztj/QQTiIV3EFYhvEisz/aCjp0lVz+JhL+rj/vufQevuQtJZ6FSp0LFHuCxss/QKn6+NJjAP5sR7S8ZhrFp/R2Ll53XbIYFDTCYGUQCO2b+FryulrLBoFGfeW/nbCg2vkDOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837695; c=relaxed/simple;
	bh=2XGvcU7k1hxtC3sQ09ccIGgApehgIwkVz/hTthBLTFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNNq+oiEIY8P8dgvu+KzI0imhn1u8Ok9UAhtxvSnwfjmAWc2M6ikAtTty5SAVwP+0vktuYSe62eV3oZ08nzfGdS0hqqfyt7JIh6yPacAue+cHJHRfD8kyBhFshp4xsjsakxBmbPVihBU/TiT+TM/Q+oB/7W0f6lHdHdTXkWSqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trZIL0BK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96470C116B1;
	Mon,  1 Jul 2024 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837694;
	bh=2XGvcU7k1hxtC3sQ09ccIGgApehgIwkVz/hTthBLTFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=trZIL0BK0C9mZnXmIALq7MqdVJ1QG6eo28lTVMZMrFJLZaVUW+TtY5goMQwPGy/a8
	 Tnw91dil62sqrjCK/ETa0aSxMqxi635zvV93KycvO/KlswKCMEnQXlh+zAK1qTnWDt
	 TeR+ji2tpIWRP9tiuqzyxPI1osp38i9rF2SGWYdybMSeSHFUI72o2wf5Pj/juv0697
	 zpPLI8YfWfr2pkEoOqa/OVxXsFVqmUpp3tf8u6TSQzF2GwAP08mrN8Gjy2HcoTLnyp
	 SLhZm+NZyN1mMYqGnrvXNN7M7agEYziZ2CiZt+kBHqicVKvMrnXt5Mu6offVoyCsdE
	 jOwCogIbXZvmg==
Message-ID: <a3adf6b1-6545-490b-a082-7362578fa343@kernel.org>
Date: Mon, 1 Jul 2024 15:41:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH 1/2] arm64: dts: ti: k3-am62p5-sk: fix
 graph_child_address warnings
To: Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>,
 Tero Kristo <kristo@kernel.org>
References: <20240626101520.1782320-1-d-gole@ti.com>
 <20240626101520.1782320-2-d-gole@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240626101520.1782320-2-d-gole@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/06/2024 13:15, Dhruva Gole wrote:
> Fix the following warnings that are thrown when building dtbs with W=1:
> 
> ../arch/arm64/boot/dts/ti/k3-am62p5-sk.dts:367.10-376.6: Warning (graph_child_address): /bus@f0000/i2c@20000000/usb-power-controller@3f/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> ../arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi:647.22-657.5: Warning (graph_child_address): /bus@f0000/usb@f900000/usb@31000000: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>   also defined at ../arch/arm64/boot/dts/ti/k3-am62p5-sk.dts:517.7-528.3
> 
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

