Return-Path: <linux-kernel+bounces-314585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9896B567
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6A91F26278
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FF61CB31D;
	Wed,  4 Sep 2024 08:48:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2A19A280
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439710; cv=none; b=KHpeAf/pxqkmzwMfoeWZfxGdOYOioHEof3o4pbStRB1lJWvPBkpnr4iRB+djYDYSprwcIL6ERjXDotPpsjZYc957+gBD9zGugNE9y1E1yThAy69rJO3pS/sNRXJCbFNdMXpXSm3Ocuen0i7lJM/iVgOnpMKkQx0kmiV3Mtn/Krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439710; c=relaxed/simple;
	bh=j090/hkalxMDsujLiYwV/Hs14wdiRIDI/t96LKm0kLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlKRUvaihPAw3tCBDsPP3CdBme61uBS0uKHhKFiNM513hZZQU0occagday8bTke3zuioysGoHHJhCJvtEJUcTa5dQ2xUAP16BbS7M9g+ph3uCxzZqR4Tlpe/UqxqQDPi2jTwMk7GftFSBgnjqcL2cQEGyPcRa8nzToNk+1gRh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllgf-00068R-KS; Wed, 04 Sep 2024 10:48:25 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllge-005PSp-6V; Wed, 04 Sep 2024 10:48:24 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllge-0004wI-0R;
	Wed, 04 Sep 2024 10:48:24 +0200
Message-ID: <9d8b7a2c2d03c04bbc898563715c1e7d0c87291e.camel@pengutronix.de>
Subject: Re: [PATCH v2] gpu: ipu-v3: Add cleanup attribute for prg_node for
 auto cleanup
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Abhinav Jain <jain.abhinav177@gmail.com>, airlied@gmail.com, 
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
	julia.lawall@inria.fr
Date: Wed, 04 Sep 2024 10:48:24 +0200
In-Reply-To: <20240704132142.1003887-1-jain.abhinav177@gmail.com>
References: <20240704132142.1003887-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2024-07-04 at 13:21 +0000, Abhinav Jain wrote:
> Add cleanup attribute for device node prg_node.
> Remove of_node_put for device node prg_node as it is unnecessary now.
>=20
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

Thank you,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

