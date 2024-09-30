Return-Path: <linux-kernel+bounces-344482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6C98AA46
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D443A1C21E23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF590197A7A;
	Mon, 30 Sep 2024 16:48:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C718EB0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714892; cv=none; b=VwW23mcCGCvR0PrNDnkkYk6BBaj0b2eV/5TuNcF6paE8lDUwnP9tL6UNmcQ4yDAGmwCRtRlUfg9pwGk4qcjD4GBrJ3eAot/SEwbNdnMZuiiNVFhk9fDa4ix9588wht4GNrQnlIBdRHW+PuLcO/Ajeoh+KBJS24BdS5DtHLjcu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714892; c=relaxed/simple;
	bh=FuvpofTPgLqgDSGrDmhE8g9UjdAkfVeTxuyGK1N7evQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XdbPo67CWBKEFXJlX8LTgV642BiPLFlBjyEkFBXf502TQ4OxjiXsz4I9y8hw47cIKdsv7AtNSLthJZEvG43Uf+hFqX1gvXlmnv2BwGG6LINNkT1RFX0Z/XVcTErN/djn5spdb6b6/LobzGISSJLhE3cD6oytEu4f9zz6Kp7HZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJZ1-0006Ut-93; Mon, 30 Sep 2024 18:47:59 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJYx-002fu7-CL; Mon, 30 Sep 2024 18:47:55 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJYx-000FHA-10;
	Mon, 30 Sep 2024 18:47:55 +0200
Message-ID: <e5e1c13576864c7baec9490af40e880f10934073.camel@pengutronix.de>
Subject: Re: [PATCH v1] reset: npcm: convert comma to semicolon
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yan Zhen <yanzhen@vivo.com>, avifishman70@gmail.com,
 tmaimon77@gmail.com,  tali.perry1@gmail.com
Cc: venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Date: Mon, 30 Sep 2024 18:47:55 +0200
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

Applied to reset/fixes, thanks!

[1/1] reset: npcm: convert comma to semicolon
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3De7b71bf181d0

regards
Philipp


