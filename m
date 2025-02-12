Return-Path: <linux-kernel+bounces-511112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C6A32612
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FE61688A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A387120CCED;
	Wed, 12 Feb 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KFDIojn1"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790D20A5D9;
	Wed, 12 Feb 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364279; cv=pass; b=ppSPniGyBTIN0hBlqMROCajTTQjgm9xBY3gH2eqp4zLe7YXEdI/GBpDKKkUnfY79Mpz61kCqG5B3H5gh2JiXx8WkyUlAMTCNCExSuTE0hnYzFXigrtGWxznEtgMwHhluPfOIOM4q/V/euX78oVSkdfoWGfsc9sMdZq/X+4vz58Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364279; c=relaxed/simple;
	bh=JBdG7HNd/1tVUtH0BDCQnqqSS6Cy6BkptAat8oiEIUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srYiachQ4oCLBCbfhgp370onGJH2pAdmh5FfiE/8YwJOmu1HVXwDxBHhT+Vp7e88qlrXmKvnqw3A7tvPWbj5llCbm47OEQJsQqrqIg+/mzLX5nq8T2NNWgG0qM+6SqPw5a4F0P5UWXK6aJnmDDAwdIfSev+E2b9KJoh66X3R9Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KFDIojn1; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739364264; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mhTek3LMOXWwE7inMGdFBQrsJZznqdEbQDauKdZXlGwi+Z9MfxqqTNkuHAcqwwYCDxnV0OG+NVNWOmAJNe3ZTxx0FgUVdwAggVNMkDGmmTrTWv61fR9qzmbcuE2iSJ8837Uhmy+oBFxF/9JpQCQJlTsODE+Z0ubmulW2P0qxMBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739364264; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k0u7MCkVugkCYytrZIZnLSDOJ7P6+i9SZvRkCovv5zU=; 
	b=ACA9jmkQalqYV3VPWJ07o8K0WZJpck8qONiPpOHlxLC9EQdGe+FwSaDn2g/7DmX9GLqCRFfkwlY6G2tUU/LycXHcUbjNxmisOKulgmG8/LCIKmcatAYvnyDlxhekL5/iyMarYWHVfjWSo455Zdb11lq6+qqBN1a/wHX0Y9wHDd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739364263;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=k0u7MCkVugkCYytrZIZnLSDOJ7P6+i9SZvRkCovv5zU=;
	b=KFDIojn1akvvSLIMtBtS1j/gY6cML0WKSgoRHfeomaqwixBDGRWuFchtvI/GL5aB
	KFl2p63f+Y8wIG9/MErZmEYc1IbDoGL1bs/sXhr9Rx2Vb6+10JW4a3dM6uSV5ry2Nij
	jOnTZh89SkxlPkYr/fKxBSsT1UfvNsyfdB4psLKo=
Received: by mx.zohomail.com with SMTPS id 1739364260281358.8015360119805;
	Wed, 12 Feb 2025 04:44:20 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: srinivas.kandagatla@linaro.org, linux-rockchip@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, detlev.casanova@collabora.com,
 sebastian.reichel@collabora.com, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH RESEND v2 0/6] RK3576 OTP support
Date: Wed, 12 Feb 2025 13:44:15 +0100
Message-ID: <5943191.DvuYhMxLoT@workhorse>
In-Reply-To: <20250210224510.1194963-1-heiko@sntech.de>
References: <20250210224510.1194963-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 10 February 2025 23:45:04 Central European Standard Time Heiko 
Stuebner wrote:
> This enables OTP support in the nvmem driver for rk3576.
> 
> I expect to pick the clock patch (patch1) and the arm64-dts patch (patch6)
> myself, after the nvmem-driver and -binding patches have been applied
> (patches 2-5).
> 
> But kept them together for people wanting to try this series.
> 
> changes in v2:
> - fix register constant in clock definition (Diederik)
> - add patch to set limits on variant-specific clock-names
> - use correct limits for clocks + resets on rk3576 binding
> 
> 
> RESEND, because I messed up my git-send-email which caused it to include
> the list of patches 2 times, duplicating everything :-( .
> 
> Heiko Stuebner (6):
>   clk: rockchip: rk3576: define clk_otp_phy_g
>   nvmem: rockchip-otp: Move read-offset into variant-data
>   dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
>   dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
>   nvmem: rockchip-otp: add rk3576 variant data
>   arm64: dts: rockchip: add rk3576 otp node
> 
>  .../bindings/nvmem/rockchip,otp.yaml          | 25 ++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 39 +++++++++++++++++++
>  drivers/clk/rockchip/clk-rk3576.c             |  2 +
>  drivers/nvmem/rockchip-otp.c                  | 17 +++++++-
>  4 files changed, 81 insertions(+), 2 deletions(-)

Hi Heiko,

for the entire series:

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

OTPs show up on my Sige5 RK3576 board and read fine. Also compared the OTP 
nodes to downstream and the values look consistent with that. The OTPs aren't 
documented in the TRM I have, so unfortunately I can't cross-reference that.

NB: patchwork's "Series" download for this series somehow lacks patch 2/6, 
which tripped me up at first. Not sure if that's a problem with patchwork or 
with how you sent the series out, but I thought I'd let others know who run 
into this.

Regards,
Nicolas Frattaroli




