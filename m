Return-Path: <linux-kernel+bounces-267878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEFF941888
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEA01C22DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95DF18455B;
	Tue, 30 Jul 2024 16:22:59 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0D1A6161;
	Tue, 30 Jul 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356579; cv=none; b=fp9yf10GayJmeF4mi1JmmCreuHiRXIS/wcOsRWsjCSmvg1C8G4dMXX9U3G6QNLXzGfsd6fgmK85AG7VVJLBFJ5HeLLffTbh9WMIhCh20db/ZVzz0ELhWFZ5Bi8qTMPoFJojb1ClI4wEFnxRrFpgQi4KAsUSHG3uyiDS2bMcCBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356579; c=relaxed/simple;
	bh=c/mVr9gTlg70oedvLOoEn2BtKUU3gEiIrg9E3aZ0pgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJjomfJGU5FGfCEwGrQ+N0shL3KrjSbYpfqefUofBqC2g/xi0JYp3MQknUJyAGsoSBpqMU72t5RNWaODo3U/oNJP4e6z/A6OhSB1lj5BNg/oBsJRoNTza/Gd5SJxaVB1ftxa6ux3DA6DCAXcHmgE7zDFlPP/MaT4m4wwbVCy5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYpch-000000002QG-0tH9;
	Tue, 30 Jul 2024 16:22:51 +0000
Date: Tue, 30 Jul 2024 17:22:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arinc.unal@arinc9.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, frank-w@public-files.de,
	Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
Message-ID: <ZqkTVygxG8cJULbt@makrotopia.org>
References: <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
 <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
 <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
 <1aedb1d4-8dc3-4e17-aff1-7cc417465967@arinc9.com>
 <130518e2-d6dd-49ed-9cc2-ca9cdec93b98@leemhuis.info>
 <aeb255ff-3755-4f76-a8f8-cda27a67f818@arinc9.com>
 <b3fa66cc-516b-4d78-aee5-62a47b52a3b1@collabora.com>
 <2076f699540c3c9d10effdb8b55d3f89@arinc9.com>
 <921f448b-4085-4c8d-85f8-478318d9c054@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921f448b-4085-4c8d-85f8-478318d9c054@kernel.org>

Hi,

On Tue, Jul 30, 2024 at 06:04:12PM +0200, Krzysztof Kozlowski wrote:
> On 30/07/2024 13:22, arinc.unal@arinc9.com wrote:
> > [...]
> > In my view, your behaviour of not applying a devicetree patch before a
> > Linux driver patch was applied, and then not replying to any arguments
> > whatsoever, was keeping the devicetree files hostage until your demands
> 
> Hm, why ever DTS patch should be applied before driver patch is? This
> clearly suggests ABI break. You proposed to fix ABI issue by fixing DTS,
> which is not the way, because it literally fixes nothing. You got
> comments - fix the driver to be backwards compatible.

I've suggested a fix for the driver here:

https://patchwork.kernel.org/project/netdevbpf/patch/f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org/

It has been tested and acknowledged by Arinc, hence a possible solution
would be to apply it and there by restore compatibility with existing
(broken) device trees.

