Return-Path: <linux-kernel+bounces-189581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08D8CF255
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24013B20EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 00:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63DDA32;
	Sun, 26 May 2024 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWUuIeOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36463E;
	Sun, 26 May 2024 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716683491; cv=none; b=X97hDTMIk34RzJZ0yePdWf8aFWe1q0GNTJVp6Ud/AghEpehMoHH8dSU2wbJ4w3e1ifKVMjRrgEiwdNhSlYc36BTmzLjq5KjAv3Lz0xE1dTG1+dLrv+C7Uir4wpis2RXKe/XBbJMH2AxTro2X5W5ZNQubuazdlpRibYcjUBiFsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716683491; c=relaxed/simple;
	bh=tLBbbj7vrivOQBPs31i4Rk8bNdwrtQx9xSQ5x5v7dRs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Cdg3HTcNjdPfqgkCOMGEkpv9J4lkAUEeqYEVWmpRDnNmYPXYbQ6vuYlx/GKcPIvs/4Xsy3BESViYS0q6q/GBzRwg8izyTmuVwDLVo3qFpv/yjUcuvHlWAGQTMXfzLtCX6JHhW2iu7hvFVjsnNX3ZMUlJRzjXV8qWxIo6OZSwRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWUuIeOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B158C2BD11;
	Sun, 26 May 2024 00:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716683490;
	bh=tLBbbj7vrivOQBPs31i4Rk8bNdwrtQx9xSQ5x5v7dRs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PWUuIeOQ2FKzGraLtFcDykcvJ/bwO54n+4BCw71Tpj0SuRXTUyRZGO9q++pZ6jQM1
	 YlJCT20K1fdKtMu8BQerJUYdcYulu9gqP3n+/SwsjLDfkUeKdGUoGdreVpRlhf6/Oj
	 SN8gxoE0atbIcU6Zdj8D7ZvIM0pvZcqk3l1QteY+dfVI+Ht/ZRdOgKdo2VFJ6/xqGt
	 7ganyu2M1LlAfOPJceyRkPHogt5PiRhYZt1EqeQMUiSWH2I6XA8dwYfMusEfaXa2hv
	 U4slhHmf4/+6mbwKlAygHM24yaVKUfVief5+hAHW3XjorkymGt54q73rYDi1vtYhOh
	 tRmHsxIxZ+Tlg==
Date: Sat, 25 May 2024 19:31:29 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Singo Chang <singo.chang@mediatek.com>, linux-mediatek@lists.infradead.org, 
 Shawn Sung <shawn.sung@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jason-ch Chen <jason-ch.chen@mediatek.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Nancy Lin <nancy.lin@mediatek.com>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240525230810.24623-3-jason-jh.lin@mediatek.com>
References: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
 <20240525230810.24623-3-jason-jh.lin@mediatek.com>
Message-Id: <171668348904.396809.16922327479169657625.robh@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: mailbox: Add property for CMDQ
 secure driver


On Sun, 26 May 2024 07:08:04 +0800, Jason-JH.Lin wrote:
> 1. Add mboxes property to define a GCE loopping thread as a secure IRQ
> handler.
> The CMDQ secure driver requests a mbox channel and sends a looping
> command to the GCE thread. The looping command will wait for a secure
> packet done event signal from secure world and then jump back to the
> first instuction. Each time it waits for an event, it notifies the
> CMDQ driver to perform the same action as the IRQ handler.
> 
> 2. Add gce-events property from gce-props.yaml to define a
> secure packet done signal in secure world.
> There are 1024 events IDs for GCE to use to execute instructions in
> the specific event happened. These events could be signaled by HW or SW
> and their value would be different in different SoC because of HW event
> IDs distribution range from 0 to 1023.
> If we set a static event ID: 855 for mt8188, it might be conflict the
> event ID original set in mt8195.
> So we define an event ID that will be set when GCE runs to the end of
> secure cmdq packet in the secure world.
> 
> This can reduce the latency of software communication between normal
> world and secure world. In addition, we can also remove the complex
> logic after the secure packet done in the secure world.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.example.dtb: mailbox@10212000: False schema does not allow {'compatible': ['mediatek,mt8173-gce'], 'reg': [[0, 270606336, 0, 4096]], 'interrupts': [[0, 135, 8]], '#mbox-cells': [[2]], 'clocks': [[4294967295, 4]], 'clock-names': ['gce'], '$nodename': ['mailbox@10212000']}
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240525230810.24623-3-jason-jh.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


