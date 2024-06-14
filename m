Return-Path: <linux-kernel+bounces-214857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EFE908B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D36A288FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835C4195FDE;
	Fri, 14 Jun 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zmo2T1k1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDE19596D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366426; cv=none; b=U3j6LHgoLM/C4uR0W5UGAKuktqY0Zf2eMQdjwqiBl34MQfQAd1e+J9skUPIkRLN33R/JWIMwZuDXrtgNRmCdZDuQmCSyLgkuli6Gqh7BuDcK91LhSWKKeemJ3XbgRYnhQXrs9UDbodyXrwtBmFHPULmamsyoCPDOx+xIYuXjKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366426; c=relaxed/simple;
	bh=bAlhxQStFAmZTApOJUn3JrhaamWFbMWxst5fkHbC0gU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=s7zPDGTpupNFRndFqhUNVUiidla+uLEFL2w8mLISJdNztDBAE2P48dcjwYJ+/aN/JdHlI5emwfCAjyL7b7+9gvRh92vgqIkVJO+m7BpJgTbCJz47sEMYeCER8ISeWYQZKdAAsfa0UMU9E1SK0jfBDPQtK0HNWbVuV/hcnPlCe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Zmo2T1k1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3ABA310C4;
	Fri, 14 Jun 2024 14:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718366408;
	bh=bAlhxQStFAmZTApOJUn3JrhaamWFbMWxst5fkHbC0gU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Zmo2T1k1JxFY7Ox3jeUaRrzQNPwnyou67p0Hk1qjQkB3kuQV2Vebe+OKunm5vb/6w
	 Ir5w6cx1/YWrUUBK0OxpRjO1wwu1M9hiWtbfIjdOtE+HsGidYNwWwpdRm2W9qKc2kN
	 4OW8ynggelj4VVeVy9npTBOm2hIudjAUC/aUuGhw=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <104f23d7-9832-4c06-92c7-d3ea84fbf186@gmx.net>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com> <20240613194150.2915202-2-kieran.bingham@ideasonboard.com> <082d9df0-0947-4452-a3fc-87eab2019e01@gmx.net> <171836496531.2248009.11650291484570726735@ping.linuxembedded.co.uk> <104f23d7-9832-4c06-92c7-d3ea84fbf186@gmx.net>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Stevenson <dave.stevenson@raspberrypi.org>, detule <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>, STAGING SUBSYSTEM <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, linux-rpi-kernel@lists.infradead.org
Date: Fri, 14 Jun 2024 13:00:19 +0100
Message-ID: <171836641941.2248009.7362589437453917188@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Stefan Wahren (2024-06-14 12:52:53)
> Hi Kieran,
>=20
> Am 14.06.24 um 13:36 schrieb Kieran Bingham:
> > Hi Stefan,
> >
> > Sorry, indeed I completely missed this mail.
> >
> > Quoting Stefan Wahren (2024-06-13 21:01:42)
> >> Hi Kieran,
> >>
> >> Am 13.06.24 um 21:41 schrieb Kieran Bingham:
> >>> The vchiq_state used to be obtained through an accessor
> >>> which would validate that the VCHIQ had been initialised
> >>> correctly with the remote.
> >>>
> >>> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state =
to
> >>> vchiq_state") the global state was moved to the vchiq_mgnt structures
> >>> stored as a vchiq instance specific context. This conversion removed =
the
> >>> helpers and instead replaced users of this helper with the assumption
> >>> that the state is always available and the remote connected.
> >>>
> >>> Fix this broken assumption by re-introducing the logic that was lost
> >>> during the conversion.
> >> thank you for sending this patch. Maybe it's worth to mention that this
> >> patch also drop some unnecessary NULL checks of state.
> > I don't understand this comment. Nothing is dropped is it?
> >
> > The newly added vchiq_remote_initialised() is itself a null-check too!
> the vchiq_remote_initialised() only checks the member remote, but not
> state itself. From my point of view the null-check for state is
> unnecessary, because most of the code already assumed that state is not
> null like e.g. in vchiq_open().
>=20

aha, I misread my own code ;-) Of course - I see it now.

I'll send v3.

--
Kieran

