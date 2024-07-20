Return-Path: <linux-kernel+bounces-258069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD89382E6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5629A1C21BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB190148FED;
	Sat, 20 Jul 2024 21:11:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8314882D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509889; cv=none; b=ABCwP7WeZkZ4bysxCxPIfYc3KmKGXjM+yhlY0hD3X9023DJw/EISdL9atDaCRlzpTAErwqx8H7BaYqUtNyFdybIQqr5U8hIJug8HIUpkA6RHAUDDOm9NREKMOygY1paZs6x1IFf37BUv8xoLQDm9TPFdSBgLyf5c7TLx1Bwv6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509889; c=relaxed/simple;
	bh=tZbVpd1wStaG/gycAw18yhtenmJMf40J6+BqXkZY19w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOIEGN+oRgln1jWSBdgxK8COYbJ+yGKdxwQaxrR9T2GSHU5P/LHJmnXO2FNZeznzKK0ZFLxzmtobmljmi2bCoQG3xFB0MTG1b13tIx4uOTeQe/EgYtjafskfW/zYVCA2Ng47PvqSEHnSP5DypGAl9+9xD+e67WfvJIVcdsHJTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVHMS-00067D-52; Sat, 20 Jul 2024 23:11:24 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: ukleinek@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] arm64: dts: rockchip: enable usb ports on qnap ts433
Date: Sat, 20 Jul 2024 23:11:23 +0200
Message-ID: <3384439.9LS3J3VOpE@diego>
In-Reply-To: <20240720210856.778014-6-heiko@sntech.de>
References:
 <20240720210856.778014-1-heiko@sntech.de>
 <20240720210856.778014-6-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 20. Juli 2024, 23:08:51 CEST schrieb Heiko Stuebner:
> Enable usb controllers and phys and add regulator infrastructure for the
> usb ports on the ts433.
> 
> Of course there are no schematics available for the device, so the
> regulator information comes from the vendor-devicetree with unknown
> accuracy.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

ignore this one ;-)

I updated the subject and them fumbled with git-format-patch



