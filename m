Return-Path: <linuxppc-dev+bounces-6699-lists+linuxppc-dev=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linuxppc-dev@lfdr.de
Delivered-To: lists+linuxppc-dev@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2828FA4E445
	for <lists+linuxppc-dev@lfdr.de>; Tue,  4 Mar 2025 16:52:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6gCz6rlgz3bnc;
	Wed,  5 Mar 2025 02:51:59 +1100 (AEDT)
X-Original-To: linuxppc-dev@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=160.75.25.115 arc.chain=subspace.kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741103519;
	cv=pass; b=I2vnZFbcilvb4muT8kIdxcjnJVp1LKt5Jx1LcPHE7Pu1d50qoewDAbS/EDrA2G9ZG2q49pjIdsUpVr3CIePUuom0vkd6jnRU6GcisIPg5SukEiWFmrC353Qf3IGBAh3KqaoFFCj8zLYY8MUsF6g7krYiofnJUPxgXkCfKz1HmYKXnYURTZTgJ6G1nZhVk11tgFeHYL6d8rIQj0Pom/BRtin+CqE3kF9tmtXtAtckBtFKdWnaKF9WoQlH5T6MqvY8FRIzUsDEU1qhSBwShtrKVLMQh+xEBR+rdAOrP2aN3QeuhohBkUgUyAMKdrpQRk4/9IEBPID4p1TlWZvHRN0/HQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741103519; c=relaxed/relaxed;
	bh=ytQRahAGQVSCO159XmRgKkX3+/eMGItsL9NJsSQf7Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaP8838gt/cuHc/PMi9CQWbY/3ZHHcdE1ySWiGl0ZG1as87eE8RYgykSsQe3zJMwisyMqTddaikam3kunPDJdDs2/GkMfRkHWSaxS/jAeND9/HoCyJ48ESNIsrMwT7VeeNjoWzfKbUKDDHXjudsf49sX/79XQPxxvRc+f2HS+I9diXCa1bA/Y3lYH4jvYIsnxzw8KW1u6k5R7fpt1h55RWdTy4Kp9VESDVnliJEA7knAFQrxGaZvxHO/G7mGtAMlnSffeeIME/WEhxDe74MywtITCDgtsSPNMsujLEEgSXXYHN8H98EKPIrsKs/Yv/cNCnWZV1GVx2UIppbTZ+8BUg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GgPH6cRE; dkim-atps=neutral; spf=none (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GgPH6cRE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6gCz0WVYz3blR
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2025 02:51:58 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id A931A40CEDC2
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 18:51:26 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g9f4Y2XzG1TP
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 18:49:58 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0F6544271F; Tue,  4 Mar 2025 18:49:49 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPH6cRE
X-Envelope-From: <linux-kernel+bounces-541756-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPH6cRE
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9768A41BAA
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:04:55 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 4BA9E3063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:04:55 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E403D16BAB5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15C211261;
	Mon,  3 Mar 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgPH6cRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866A1E521B;
	Mon,  3 Mar 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007072; cv=none; b=OzhBZu3bTGjeVq4u+0o43R47bVjqOKnc3olTd/nMB69xdsdDz2KVklXiR96AXPHm4uk9qaptXD11b6Z9EPm0cjkzXd8NqHBNelFbUu+LExHmPKrsIp/CEz+myvYFLnB3ZLVQV3hDaBbihn0v9mv8IOgJJ+9NbY2S/P7/RwQd/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007072; c=relaxed/simple;
	bh=MJ1eWiZF1zNkmxOw5SUe/EJwnqJlYPHJ1CHEJLkZExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfzliipKHexhhTVTFkYeJVkzFG5x6XV6rMiTrC5tr0InuF77reacHba8XoOI/UwCKY2so4U5Kp4OM1mT7KuOJj+zTiMo2XacDsXjH3u/tytg/dFHs8KHqlzPBwtlHtsm9qFdk/nEsgx0HHOLPsVQ7t/hCQD5U3HHlT+QUYO00z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPH6cRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FA3C4CEE6;
	Mon,  3 Mar 2025 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007072;
	bh=MJ1eWiZF1zNkmxOw5SUe/EJwnqJlYPHJ1CHEJLkZExk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgPH6cRERh1HMBBuEM2ytiHoxcEIyQ8WHaLHvhXD58EXv078Ru8hCw/x65dwmTBP4
	 FnFXmWLTsOU2oI4ghoXEh/wKW6v0/L48r4z67qBYN6A3oQgbrEwpSlrM8fUdueHRWm
	 7i6xuao04uAPUVg51r9+Da3fmNWu0+Ba3hDEJWB9NoTvSSbXmsmKSHfXjPJwj5sCQS
	 ZVwRqbXN2/6xym99sAr/ifjoVnDgXVFKOvgx2jKJ/+wu1R4g/glb6BqWV38wtbCTVR
	 d+vB32cooXYt02OsyvInT9tfzxmHwfMrTt3bBR5MRTAwQuAO9dD2pTBBP6zar3cWI4
	 yIDrZdw9lr/ow==
Date: Mon, 3 Mar 2025 07:04:30 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: tiwai@suse.com, Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
	krzk+dt@kernel.org, broonie@kernel.org, perex@perex.cz,
	shengjiu.wang@gmail.com, linuxppc-dev@lists.ozlabs.org,
	conor+dt@kernel.org, nicoleotsuka@gmail.com, festevam@gmail.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: dt-bindings: fsl,audmix: make 'dais' property
 to be optional
Message-ID: <174100706937.1425909.3592597206519179445.robh@kernel.org>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
 <20250226100508.2352568-4-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226100508.2352568-4-shengjiu.wang@nxp.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g9f4Y2XzG1TP
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708214.95629@oLrkvB+Hgqc5T8tIWEIF+w
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-1.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org


On Wed, 26 Feb 2025 18:05:07 +0800, Shengjiu Wang wrote:
> Make 'dais' property to be optional. When there is no 'dais' property,
> driver won't register the card, dts should have audio graph card node
> for linking this device.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,audmix.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



