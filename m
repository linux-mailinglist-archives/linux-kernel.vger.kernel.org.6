Return-Path: <linux-kernel+bounces-527699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13828A40E45
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E3F3BBFBE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE112063C2;
	Sun, 23 Feb 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syl/keVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FE1FC0F2;
	Sun, 23 Feb 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310122; cv=none; b=h7mL2HERH7BkVvDnhc4gDuAQGO6FIRnyc9Tw2NfjYjjkKRnZ8UpfrRbdc42jT0dVHL0LIwQsFbwiU7egwA6lPBSSo6K1P5dmBOsjA+vkTQeez/Pj9WSY9LYMHKuIOYOfHQdeER4ifQKWRdVS6ezoJnhrSTInjc+7wj58HhrVh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310122; c=relaxed/simple;
	bh=NlJVydL9C+hEsWptR74iKVv9eBDBElH8eho8n1pJeh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmOgpiHJjjtJmLmocb7HaieIAibCK9jx2ESJVNFUukC6aptKlQoS2TFe1L3TDijNZ4SMZYrBE7SCH42k8iu6PTTaJ39qQSUlIeS+VuKjXP62aCTNUDpko6SDZH4LxbnsnzN/04nipnsarpiMpos60a7LxekRCqbkPOWsuBTHVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syl/keVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD15C4CEE8;
	Sun, 23 Feb 2025 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740310121;
	bh=NlJVydL9C+hEsWptR74iKVv9eBDBElH8eho8n1pJeh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syl/keViV1NJaBjWAYL9EX9JMR1GB7kQbUTbaPtuRJAzfbTpIZej5WEewDE+SsE8U
	 hhkPpq+SiYaP/Q9k1F2t9bwFIL6s5Jv0wDLnbNe00N3vWyE8ylusy2v8k3ZrbiGXMs
	 xeO6gMi1JiZKrGz4pFSvA7WhaeZy7LRRKYqP5Zy1Gf0YHBSRgL9GL7p1vl2i7Ed+CG
	 onJIBC66sM6FX4CSy67VtVmTyZJlMqFNiHV583MbJg/I5qqA8VNCUKc5CPDxredv1X
	 Hp60WIUIiVFT1EvUPiDEZpqBgj5QJSuh576Rr2iael29FZjRqhsCEeSv7pbaI/0v0P
	 8l5XLWwhUtuJg==
Date: Sun, 23 Feb 2025 12:28:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek,xsphy: add property to
 set disconnect threshold
Message-ID: <20250223-benevolent-tacky-emu-f5f1c1@krzk-bin>
References: <20250222090710.10909-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222090710.10909-1-chunfeng.yun@mediatek.com>

On Sat, Feb 22, 2025 at 05:07:09PM +0800, Chunfeng Yun wrote:
> +      mediatek,disconnect-threshold:
> +        description:
> +          The selection of disconnect threshold (U2 phy)

Say something more than just copying property name.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 1
> +        maximum: 15

default: ?

> +
>        mediatek,efuse-intr:
>          description:
>            The selection of Internal Resistor (U2/U3 phy)
> -- 
> 2.46.0
> 

