Return-Path: <linux-kernel+bounces-214662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41BB9087D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE5B1C22220
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED633192B9C;
	Fri, 14 Jun 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QjlawHfi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bb7X2Jr5"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD4194138
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358257; cv=none; b=Re1DU19sur6b0oUcoc3zbEd+RyPHSk+cuC93PDXQu1p3ywT+93G6RTIIb6FTHz2DThJisc8mwNFXCuKrIpzGnidCx/ZqHEWRcBrmw6x1/G94veMpKwK+zRzbNKlE1D6YVUwyxGus9KTspOyvhMmBOqwttjOt74TpD4Hg3LMU3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358257; c=relaxed/simple;
	bh=twUgCA5lLEEXRaSSd2kdE7h/lkvHV3RfmLbmB60fE/8=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYHxZ4DMPaMXRT+ShF1xAmlEanxYnI3OpZb7H/AgOppbO4PC1jEZ0T2Ta/BJ43opHsN3/aKyKp3gOab1n9lYnyQ7r6/GezPEmqWgbQ98hGR6RCQDCpF8ttglTdmW5z/bFlGPFDDZ4qVlqzoJPQBzRpP3F5Amh5pJq8L6xRG2cQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QjlawHfi; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bb7X2Jr5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718358254; x=1749894254;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=KqutV/9zmAcolTorfUzfmzB3+gVeK0ZvJ8Jk6Wn19IM=;
  b=QjlawHfiq3ui8dtTIqUemDD8dXO2QHY2Jl5FkcHtkIY0GzMCxZpyzCfx
   xdqPt61FUNMggxmSWH3hVPyKMcYrxGz0jQ9J7W89SD9ZkIirebl8cGBT6
   ucWgm68lMuD4bm3KKhr2S+sH1v+SJ2c5bn/xYa3f3aOLyFdlZcFF065yk
   +lXSAKmYWMZ/3t3VV+I/diPXNXskfcZJjw4ZVdMTKt8U4Z3P0ogWZMYFK
   DeTWRVWEucPu2eicOaewkg7EFhWrChZOPuqY3f9qAfWHL7ylmoLgQg23m
   3xo3cAV2lx5ATiuFdub2NSpoBfKlu+8NjbVGNDt+vzWTZC1PbYLPUoT/v
   g==;
X-CSE-ConnectionGUID: bnPp7kDhS5SFayMOY3PHAQ==
X-CSE-MsgGUID: 6PM2ACNiT424mdxsNDoCCQ==
X-IronPort-AV: E=Sophos;i="6.08,237,1712613600"; 
   d="scan'208";a="37396626"
Subject: Re: Re: [PATCH 4/4] mfd: tqmx86: add I2C IRQ support
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Jun 2024 11:43:02 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97374160F4C;
	Fri, 14 Jun 2024 11:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718358178;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KqutV/9zmAcolTorfUzfmzB3+gVeK0ZvJ8Jk6Wn19IM=;
	b=bb7X2Jr5A/JkS72R7HFoRrv8eroi/jFrOWiQ0uJOjBk5y6EvWoMcsuMozgX9jxPXhYi5q6
	O5AmkBaP3w9hD/Al+KWD5ZqlGwFyMuXwLdmJt5rDcevEEEe2o3D6NhkwzcmB0VfCzFa/36
	aBYEJDzwBovNCwGp8Fyk8gWyPkABniW1IdfOwTmGJwChEydrlIgthO/9TawlVeQiad09zO
	zfa5984+dncmNDBPmxg8y67gqaUTj89BBIy/sjL3B9FIWhqeNPZO4GHEl8y+Cn6eBATBxP
	H5GnwgTD3LEMpjKASGKfLAMPPuvB3ioVk2elZqQ+OcJHfcbR8abiKxgw0jV5/A==
Date: Fri, 14 Jun 2024 11:42:51 +0200
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Message-ID: <ZmwQkHvCdB3rPGEw@herburgerg-w2>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
 <18d0348f2f7b70329e44f7759bad7e6fe231dba0.1717499766.git.matthias.schiffer@ew.tq-group.com>
 <20240613154234.GJ2561462@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613154234.GJ2561462@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Jun 13, 2024 at 04:42:34PM +0100, Lee Jones wrote:
> Just one question; what is (7, 9, 12)?
> 
> And why is it the same as the GPIO one?  Copy/paste error?
> 
Those are the IRQ numbers of the PLD. Both blocks, GPIO and I2C, can be
configured to use IRQ12, IRQ9 or IRQ7.

Gregor
--
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

