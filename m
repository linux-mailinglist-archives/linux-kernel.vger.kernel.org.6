Return-Path: <linux-kernel+bounces-377414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BAB9ABE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B70D280DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77461482F6;
	Wed, 23 Oct 2024 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="X7iuuQmt"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE2EAC5;
	Wed, 23 Oct 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664104; cv=none; b=uMkZ5fLndu4R3Zv8204oRPjGsvE7UdVWcx0gwqO7YtUlDX5UH2pK7ukCmem6OJoeEmx4rsGRi+xnbJg50y6fhIJrwrramXH9kyn2WIT+PWKCybT9uKz0j6XZuWn+WumeIB+Jf3pokpPDBKR8NLmmdY9dz0q9i7FxBr/ef+z5MZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664104; c=relaxed/simple;
	bh=uPW4iOmh92n0FdWJ1U1PBgbj0zGgvRYGMjRMNUlwlTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Adyp0o/NOeQF32FfTzIuTKIF/GiWEdJIMhkiF1TjeqVkvJoEI4OJapR6raP/AveVUNiCUhgB4v4ee1PiPLyfmmY8Z/Z5CH+rYL9E0kamiWUZ9q9jgikamNkxcgXQP/srXO5fqUFDBnpwLE89XG3wwaXWojVCKExdcfhp42t9X4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=X7iuuQmt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729664098;
	bh=uPW4iOmh92n0FdWJ1U1PBgbj0zGgvRYGMjRMNUlwlTA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X7iuuQmtFguQG+IJh+TWz3WceRdZtTv0UTTY3M8mvcCXfZEgzRTEnQbL4xosPwdjh
	 PdOeK8A1aYSHt2AN2kSU+h5erp2a53AwQqDkrUlvGVuKSRKnBBAOcEmjNnPb0U3e7x
	 WReBijoA0h92pnsWY2QEsY0Yxi744vJU+s+KbgVXaEcwhR6d71YPhR2G0Vu7Iktsae
	 A7Hyvyv8jd5I8B/ArQ/FWIqp53IwC7J+5bK+sMEPfF0gg79zVld4mGVlmNjgmN7BD7
	 xG1s96ZC2UTO32IzSGgLuVFFCdZkMrzGxvCldZYO+XMvsbeGquVnFMVYrEbpNa2ddt
	 ZoFkgx36BiABA==
Received: from [192.168.68.112] (ppp118-210-190-208.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.208])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DCEE069460;
	Wed, 23 Oct 2024 14:14:55 +0800 (AWST)
Message-ID: <de478e5f56bb67a9babe59afa6ad53c8dd4542ee.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: yang.chen@quantatw.com, jerry.lin@quantatw.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, patrick@stwcx.xyz,
  devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Oct 2024 16:44:55 +1030
In-Reply-To: <20241022021230.2322132-1-jasonhell19@gmail.com>
References: <20241022021230.2322132-1-jasonhell19@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 10:12 +0800, Jason-Hsu wrote:
> Add Linux device tree entry related to Meta(Facebook) Ventura specific
> devices connected to BMC(AST2600) SoC.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

What commands are you running to generate and send your patch series?

The patches must be threaded properly.

`git send-email` or `b4` both do what is expected without any effort
required. Please consider using them, particularly b4, if you're not
already.

Andrew

