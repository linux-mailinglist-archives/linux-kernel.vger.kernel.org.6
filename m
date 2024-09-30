Return-Path: <linux-kernel+bounces-343345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997C9899E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FC1C20EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30121126C18;
	Mon, 30 Sep 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dhBbApo8"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573D1362;
	Mon, 30 Sep 2024 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671784; cv=none; b=GEZoYuIFuMbF69/H+TgKc3OQgco4z2kf5j0QzeeEa+lyADy0ZZvztp0yDvY74Dqf/2dZf67pQSoiCCBCAaT96mccAGjr191nSZL7hWd6oR3QXSmoh/V8F68Uquf9u+ga3O33PFAy7rRCd0q0WHCCzeB6icoDCC5kj0lSA/0A1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671784; c=relaxed/simple;
	bh=UD2DCO8YUlUfDsNi37YsXaQP4ORhuk+wrvj0M/8IxiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JH0pvpaf42wiDI2/h3K9bZfUASzQPPJF2XuSJmd0ePO+QCCZbVQekK/29+GErK0bhxb9Bn4sqiH9xUg6j5CGhJ+vw7s2LPNSa5BOod84nqnPosG38b7Yef81yDpunALkHD/+wRZ8wEjInfan6xOVaa/7ALlHZG6+romW08FZp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dhBbApo8; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727671781;
	bh=UD2DCO8YUlUfDsNi37YsXaQP4ORhuk+wrvj0M/8IxiE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dhBbApo884+w12iNss1QJd5QAyrd58r9xAbkl3VcUIhxURO4xEfXvf1oFpVozAvNb
	 zUjTGOkXN63SMoR/pNL2+xg6LIb7JVbHXIxEJwWBvHlnEzP3ZQG9Oq5Sn1IeE723bQ
	 q3RoA1lxjpAP/YV5BCr4ETg77LaSbeorCyU3LR8WlJsGFOONZKZdDRiIv9vKc5p8H+
	 r9iaoQNrBb8lxDtZt/uWtpC9UfX5nswuFtpGrsOYhb1DTsjVB4UR+3sO/jR3OL7Cmn
	 E+YtHGthPsfmLJXwZ3svLKshOlLZBYc200ApOMSYlwNAadL6K5GxWIowI6XX/wqkzU
	 FydY+CxFKlKxg==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C0A1B6511E;
	Mon, 30 Sep 2024 12:49:40 +0800 (AWST)
Message-ID: <a6c844509e9b8b7b38f40f1280d02e4e0e19d57f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: nuvoton: Add UDC nodes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "William A. Kennington III" <william@wkennington.com>, Tomer Maimon
	 <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 30 Sep 2024 14:19:39 +0930
In-Reply-To: <20240925093956.2449119-1-william@wkennington.com>
References: <20240925093956.2449119-1-william@wkennington.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-25 at 02:39 -0700, William A. Kennington III wrote:
> The driver support was already added but we are missing the nodes in our
> common devicetree. This enables npcm7xx platforms to enable the udc
> nodes and expose USB devices endpoints.
>=20
> Signed-off-by: William A. Kennington III <william@wkennington.com>

Tomer: I'll apply this for Joel to pick up if it looks good to you.

Thanks,

Andrew

