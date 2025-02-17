Return-Path: <linux-kernel+bounces-517850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60E4A3867E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B674188729A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED5222581;
	Mon, 17 Feb 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="X49o8xJy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1656B81;
	Mon, 17 Feb 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802840; cv=none; b=MmsvSy7Y+BT9JyyXk9xzizi2pmlwpKrZkRQmxqrWA/kijh6h/5u7py1mbg2AjrIIFcCmqGuxGjUT41VoiGMeX9Q/4NzZOrBlG+XMWjdO4sYwaiPFl0nDfPx4Rmy6mmoGUZcpfbg7R1uRk8F+PcllMeE4S++lclMdCs5MCI26aZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802840; c=relaxed/simple;
	bh=oOzTrJn4cqq1Ti5AP6YeTm7zo2qDVBTeWc/YGRAyb+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kH0BIF35v2VDDzDT1pHraW8UB6iKmefpWR5dn+ry17bsOgAT0FFDVtgw6mVFr8jBBeaEssDb7ZvSaTZvYgPbPVbJMHtztkvv6WqYwy7gKXlDbZPNjc5EYX31HXL4eLhr1sX3Ttbe1PD4I6UoEBKxhbqMVvfn1MiCuz6IPS0RZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=X49o8xJy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j4YfzZyj7vkcD3SCN4L4GGNfCjFE9FR8KFVGORtDRkQ=; b=X49o8xJyLo64xwkvS3Z0DwKYKI
	MUbiT1h0JiTIFhstAoG3Ep6byovmYPCT8L5LdMCvkdD81fEuLDXm+P2IF0/Dr3zcj2CoMAS5+j/rM
	m5jKvicEr40u8rmgJHkGr1QdNxfHDqTRb14csicnrpOQYMSujOidVAB1ynFHh7oZRiaZDW59JQlCn
	+vlGm/kcOpA+BH36UsB09DVEZA7hz5xc4fsUbdpXyje8yv/62IoUz96xcxpHiJbu/MJyR/fefFwhP
	7ljxtm+2Y3ESwyJSysFh/Wye3fks7ENaPmGahpS7qPRGN+f7claxKzF3MzVeHx6tWEFG9Gyh0lIL6
	KjuxCP/w==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tk2Bq-0003zV-DR; Mon, 17 Feb 2025 15:33:42 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: cristian.ciocaltea@collabora.com, Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: airlied@gmail.com, andy.yan@rock-chips.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, kernel@collabora.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject:
 Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2
 on RK3588
Date: Mon, 17 Feb 2025 15:33:41 +0100
Message-ID: <5190979.MSiuQNM8U4@diego>
In-Reply-To: <20250217024437.35155-1-liujianfeng1994@gmail.com>
References:
 <20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com>
 <20250217024437.35155-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Montag, 17. Februar 2025, 03:44:37 MEZ schrieb Jianfeng Liu:
> Hi Cristian,
> 
> On Sat, 15 Feb 2025 02:55:39 +0200, Cristian Ciocaltea wrote:
> >The HDMI1 PHY PLL clock source cannot be added directly to vop node in
> >rk3588-base.dtsi, along with the HDMI0 related one, because HDMI1 is an
> >optional feature and its PHY node belongs to a separate (extra) DT file.
> >
> >Therefore, add the HDMI1 PHY PLL clock source to VOP2 by overwriting its
> >clocks & clock-names properties in the extra DT file.
> 
> There are boards that only use hdmi1 such as ROCK 5 ITX. So there are two
> choices for this board:
> 
> 1, Enable hdptxphy0 as dependency of vop although it is not really used.
> 
> 2, Overwrite vop node at board dts to make it only use hdptxphy1 like:
> 
> &vop {
> 	clocks = <&cru ACLK_VOP>,
> 		 <&cru HCLK_VOP>,
> 		 <&cru DCLK_VOP0>,
> 		 <&cru DCLK_VOP1>,
> 		 <&cru DCLK_VOP2>,
> 		 <&cru DCLK_VOP3>,
> 		 <&cru PCLK_VOP_ROOT>,
> 		 <&hdptxphy1>;
> 	clock-names = "aclk",
> 		      "hclk",
> 		      "dclk_vp0",
> 		      "dclk_vp1",
> 		      "dclk_vp2",
> 		      "dclk_vp3",
> 		      "pclk_vop",
> 		      "pll_hdmiphy1";
> };
> 
> What do you think of these two method?

Going by the code in patch1 (+drm-misc) we have:
  vop2->pll_hdmiphy0 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy0");
+
  vop2->pll_hdmiphy1 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy1");

So the clock-reference to hdptxphy0 should just result in vop2->pll_hdmiphy0
being NULL and thus ignored further on?



