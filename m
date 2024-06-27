Return-Path: <linux-kernel+bounces-231758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6874D919D89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DA0284F60
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC721171C;
	Thu, 27 Jun 2024 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZjtFqDAt"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3E23BE;
	Thu, 27 Jun 2024 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719456544; cv=none; b=iO9xq2RHk7w1BeJm1dpANQ+o/2BuPu/hVDAw8f9UEE/OvY2Xs/GDw/pTQeX/ODFSNr8IUf+awP1JcIsaTtDaJNG/FTAL+L5ih0WR8IkIb94WIn5LHDt7LZokB+bu9aTeTTBMN7yuHI1FFb1soWh5TKqDYST0FfpXEoUBuF489Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719456544; c=relaxed/simple;
	bh=C4OBiE450vWH/FOqUr+gfxzxQDXEsOmJtXQ3rpvHN2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ez/CdzL3CW9fUN6bsIq8wwQwjGAWpCjO0jkctbEHrBjyKH1tw7NSJuyEllryDbWTQ4V61zQ3lJhhY0rqwrvh0Jhi9AAQi/Fw3HzFNl9L7GYObi0Mn34LrxkapV906VPGfmgm05z1MNdK7GJCOcyJtYq807GkXHMEbd/p9vnzTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZjtFqDAt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D9F8E200DB;
	Thu, 27 Jun 2024 10:48:51 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719456533;
	bh=QRdGpdPwEF8z1guRBaFF3J8Ugc77/KDq1zotfXxXxRw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZjtFqDAtVuHtBXrtGvFabQOkgMmEQoFHAiTQj222vQC92t2cbTj0C2tJhwN9kBRpR
	 w024zJxvSkFqHrXGvQKyZEUbuJzrNvW+Jk2yKKI8JRMktBfbJR1TY5FiUNDSkNzG4Q
	 gV+zeDBX5nkFL2MzJIf1/WwPz8VE7YLEVY8uA+V9kPQ7hPJGmIW0LHQYmanqEvGLnu
	 /cYp3bXCODA6/+C3Xm/QCZVRUksrgD4S8NMl2c4sWMFCGmvjztApCba+zZc5vv5RjV
	 qcT/1yKnxBq8JvKw4QZ4PCsUn6Ajsh5gXp9HmyZCc1TAHrXw5JC3lLoqi63BfzV844
	 aI6YAXovI0HjQ==
Message-ID: <f7412b65e1844ea9f3ad9fe5825e5d1da422ad69.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 00/17] Revise Facebook Minerva BMC DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Yang Chen <yangchen.openbmc@gmail.com>, joel@jms.id.au,
 patrick@stwcx.xyz,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com
Date: Thu, 27 Jun 2024 12:18:51 +0930
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Yang Chen,

On Wed, 2024-06-26 at 21:03 +0800, Yang Chen wrote:
> Revise the Linux device tree entry related to Facebook platform Minerva
> specific devices connected to the Aspeed AST2600 BMC.
>=20
> Changelog:
> - v1:
>   - Modify the properties of spi to match the schema.

I've put this series into a tree for Joel to pick up.

Thanks,

Andrew

