Return-Path: <linux-kernel+bounces-189782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E38CF4DA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3301F211A1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE501863E;
	Sun, 26 May 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/92gJPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345418F6A;
	Sun, 26 May 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716740020; cv=none; b=SEqDgWp/A9+tU3FsarX0t2Ain/2YJXHCBmClUHRdFigk6HS3i0UGHo1XDRPeHDB5vPiO88f3wjBpjrFngv2y2aBtD9xKNyX96/6mF4uUYZ5ztvt05Am6DwrY2AYkO8DJXRGhSvqreMD5+/10uhvWirfUDiCVpUvKQxgtdCOeonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716740020; c=relaxed/simple;
	bh=leD2S7lpS8n5EdWPOzT2u2+2bVeUmpHLgfDZY3EfIow=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=hbxRJIpwvEbYXu/BTKuqCOzTdYMkZJHkqTOI0EOzyXjGpVXpZdI8qONchzwfqSfeWszMgn5c28tSb7qTohoxeLn2KtuaxxXKF5Jv/+7WgdQyU5nLDibIelL7LJFKo2Z286kPuDs7VAouoV5bhkNevRUNBZCJRabmSExhA7A0ZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/92gJPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA1AC2BD10;
	Sun, 26 May 2024 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716740019;
	bh=leD2S7lpS8n5EdWPOzT2u2+2bVeUmpHLgfDZY3EfIow=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=O/92gJPIjF8h703XZyIrycQN5bhPIfL5bQPmr5DgAPmGgDDKXrDPq3vHLNjXDStd0
	 l10/ktzrPqKjDKHqMg4GWoUDdHxvgaO3Pnz6tjcZ60AQoCqOJI+OglswsCSq9H5VDU
	 pQE5xbgDrhCCfMazsLYfJ+zBFbVqxJtT3Cr3Z+Y4uPM5zbZANNuNImzGPhnhtQbWNy
	 dhmwoZAL8e2u77Y/GHbDEXe9gUYuisBnZ4f8a/Lu+SGKsjU8i4/Xekz5h54CXXSIHr
	 Q1dAgnBD3YzA+U2VPioe4/VqTLziOGyMeTdf/JpXEQ4PbJH6NMbNyp1yAG46C/gFNQ
	 rxMLI9nun3CQQ==
Date: Sun, 26 May 2024 11:13:38 -0500
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
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Singo Chang <singo.chang@mediatek.com>, Rob Herring <robh+dt@kernel.org>, 
 Nancy Lin <nancy.lin@mediatek.com>, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Shawn Sung <shawn.sung@mediatek.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Jason-ch Chen <jason-ch.chen@mediatek.com>
In-Reply-To: <20240526144443.14345-3-jason-jh.lin@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
 <20240526144443.14345-3-jason-jh.lin@mediatek.com>
Message-Id: <171674001829.1684465.16088341885457355919.robh@kernel.org>
Subject: Re: [PATCH RESEND,v6 2/8] dt-bindings: mailbox: Add property for
 CMDQ secure driver


On Sun, 26 May 2024 22:44:37 +0800, Jason-JH.Lin wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240526144443.14345-3-jason-jh.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


