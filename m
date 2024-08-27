Return-Path: <linux-kernel+bounces-303886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9095961681
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14172813B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF61D2F55;
	Tue, 27 Aug 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Wm9L9vdj"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B781D278E;
	Tue, 27 Aug 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782354; cv=pass; b=bN6fhDj9X7HRAYv0qZ9Y3YCqI86wPfsbMRNn5mCNocig0GqzZkvbj6vf9gHdvWL++vBZMBDljE36B9xlOBGmErhy1lJCzNfDZDlYsEBMkKOdJSHjmY50cn1buH+Kepzqj0obl3BMPMVovtcNUvU60II0SF5tuB3BjoWL4INk4As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782354; c=relaxed/simple;
	bh=J0nlL0k8K0CdceKb/pE5s3t02sGFvTtGXiUdTmRuhKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nok69IU9/SEaNeU6WDtyvL04QVN4GPk6k8GUQdKTqSmIUcdEDyy6zNj6xrJIHp0Daez0Vz/rsKc6PxjxZJV5Nrt84VzAMs4DmJL14Q2KrKfxIkNt0gZkGMg9yFr2Rml5JacWUVNurlnkGmTLIfTPkOxvmXLz+j2CQb0RQy8Z+Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Wm9L9vdj; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724782336; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AD8W6kAm8KPGSZgZBoT9pLykuSEEZq2RpGwBx13bnlUTsQB00sOtYARnlzVhCCabLqAME32xRJPlTMwDimdFNnO5wI63ppNqwVmugDaP96LXSBAbbUPLAdSAeJhFvyunPVv5MznK1f2WDKbk3ACE/5fwxR6VaehmkLYI5EQD/nU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724782336; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AwEUECrk+z0V3RuQ8yKIRI9nzPk828sBA4f9z6w21Ew=; 
	b=KIR5jjy4K85EihX935WLaGNg2C/OoefSZ/9xbOR7DYcSteMF/T6B+wWgjmmh83aiKrS0KWIgCSTacb0qYHq64POh/VBhILQYdM5MXa4lMOcDvqBfkoeYpD51o3gLRqV+hOqElkFef6xZpgkYWwUkIjuVf13TfSOeRXf1Fl+QEeE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724782336;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AwEUECrk+z0V3RuQ8yKIRI9nzPk828sBA4f9z6w21Ew=;
	b=Wm9L9vdjugz2ihLsawk1JxZOSRr2IvWjnhzlDGswP0O+r+2owa9rALlB1NufPuiF
	QKfbx2rV7liTMnAfiEigUmvEp76xjIlcMu8DdSBk9zkV61QUtEi331ZZNL8as00r+f3
	8aGc2Kp1SpLJ0L4Jo7EFXiiv0FKPcTzCryyE+DJk=
Received: by mx.zohomail.com with SMTPS id 1724782334796848.0770855338741;
	Tue, 27 Aug 2024 11:12:14 -0700 (PDT)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E31E14800F4; Tue, 27 Aug 2024 20:12:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v8 2/2] arm64: dts: rockchip: Add VPU121 support for RK3588
Date: Tue, 27 Aug 2024 20:10:21 +0200
Message-ID: <20240827181206.147617-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827181206.147617-1-sebastian.reichel@collabora.com>
References: <20240827181206.147617-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

From: Jianfeng Liu <liujianfeng1994@gmail.com>

Enable Hantro G1 video decoder in RK3588's devicetree.

Tested with FFmpeg v4l2_request code taken from [1]
with MPEG2, H.264 and VP8 samples.

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multim=
edia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588-base.dtsi
index 595f129a2d8c..14b8d8691255 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1122,6 +1122,27 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};
=20
+	vpu121: video-codec@fdb50000 {
+		compatible =3D "rockchip,rk3588-vpu121", "rockchip,rk3568-vpu";
+		reg =3D <0x0 0xfdb50000 0x0 0x800>;
+		interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names =3D "vdpu";
+		clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names =3D "aclk", "hclk";
+		iommus =3D <&vpu121_mmu>;
+		power-domains =3D <&power RK3588_PD_VDPU>;
+	};
+
+	vpu121_mmu: iommu@fdb50800 {
+		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg =3D <0x0 0xfdb50800 0x0 0x40>;
+		interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
+		clock-names =3D "aclk", "iface";
+		clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		power-domains =3D <&power RK3588_PD_VDPU>;
+		#iommu-cells =3D <0>;
+	};
+
 	vepu121_0: video-codec@fdba0000 {
 		compatible =3D "rockchip,rk3588-vepu121";
 		reg =3D <0x0 0xfdba0000 0x0 0x800>;
--=20
2.45.2


