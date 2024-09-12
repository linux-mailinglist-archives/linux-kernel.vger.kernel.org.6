Return-Path: <linux-kernel+bounces-326162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE49976418
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3945BB21E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFB18FDDB;
	Thu, 12 Sep 2024 08:13:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E436C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128779; cv=none; b=kyMwgI5fzu+8KIQzyzUd4F8TqVvvu+NIpK3Z+zwJ1KH6qTrdnLUHt/oDf5X4p59Klsug5GPSyv0+9r536r1sbtSVCdy95zNVc1z9RDmHZJZ7yzrzNIMNlYxw2COqVdH6p5TXLPbwQCoXtrDIZAn4tBEZGkIpZKekL6gineT1YC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128779; c=relaxed/simple;
	bh=tFc20qYi8G2nsGh4yLlGq+s03iVNuXtFC3P3F5JNYvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNem59NaAwmDFfCyc0OoimL2tGz+np3qJ34EMQoYKvisR9FU5zy6p0N2w13JDVeQsR46Sn7IdhQMajMtHZn6b3h15arspYuubWZNzqXq/aRdc3/eWYgCkrrQGsmK6XeEauiXv7OsGuC3R5tgsCjz2HVS8M1rzOSCFcF5NSjTYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soewa-0006tl-H3; Thu, 12 Sep 2024 10:12:48 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soewZ-007Kw9-0z; Thu, 12 Sep 2024 10:12:47 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soewY-0002V3-37;
	Thu, 12 Sep 2024 10:12:46 +0200
Message-ID: <d94539ba211906d3ecfed9446258870762a72acb.camel@pengutronix.de>
Subject: Re: [PATCH v1] reset: npcm: convert comma to semicolon
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yan Zhen <yanzhen@vivo.com>, avifishman70@gmail.com,
 tmaimon77@gmail.com,  tali.perry1@gmail.com
Cc: venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Date: Thu, 12 Sep 2024 10:12:46 +0200
In-Reply-To: <20240909061258.2246292-1-yanzhen@vivo.com>
References: <20240909061258.2246292-1-yanzhen@vivo.com>
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

On Mo, 2024-09-09 at 14:12 +0800, Yan Zhen wrote:
> Replace a comma between expression statements by a semicolon.
>=20
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Thank you,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

