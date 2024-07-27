Return-Path: <linux-kernel+bounces-267804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D09415A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B49B23475
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3FD1A2C11;
	Tue, 30 Jul 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hfel.co.uk header.i=@hfel.co.uk header.b="QiYZId+I"
Received: from imx.hfel.co.uk (imx.hfel.co.uk [185.209.160.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E82A1BB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.160.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354394; cv=none; b=uGQL4A7B6mK6jpohCG1YEhhrwA6l3PtVWxvYlPFDMm1PZsOlK5va326KPj6kPYZFmU4Jw4g3sZgrNk5oZn9IpRckHpMa9ZdTXb8ePS/wcl7IymohgAIEhourWmlqzWe4Ypvt8EP1/npq7ZahZwgvx9HY7S2KnAtfQ0e+SbOQMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354394; c=relaxed/simple;
	bh=QpGUXo1p/U7TCvHhofv2wP5mWlKUkFjERkTq/aN26cY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVlRseXwFQdKbNf4+i7OSjJL4TuqwQRUOokatiZhcWHzqzbv0wGFl9Ga2bVHnOzBlxVLcxXmSt/EZdafrPlLCtyPs//px70CY4ZvLNDTpHicRtNAHt6lDex78ymnXxi/P+T9eIgECnO1gqQ0u0+MMDmmdTpfRwz6viiAt0qnZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hfel.co.uk; spf=pass smtp.mailfrom=hfel.co.uk; dkim=pass (2048-bit key) header.d=hfel.co.uk header.i=@hfel.co.uk header.b=QiYZId+I; arc=none smtp.client-ip=185.209.160.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hfel.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hfel.co.uk
Received: from [45.145.42.199] (unknown [45.145.42.199])
	by imx.hfel.co.uk (Postfix) with ESMTPA id D59FA9F917
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hfel.co.uk;
	s=default; t=1722101071;
	bh=QpGUXo1p/U7TCvHhofv2wP5mWlKUkFjERkTq/aN26cY=; h=From:To:Subject;
	b=QiYZId+IqVBl+x+xCNo0bnhpCyE5zZ+mZ1nmTlxrYDqVxH6TUvg1Tt4Jlm8c9Sjor
	 S0WZydlpjMVammFmOv9rcdnAopPIwHfVu5XqruOIOFio0cjJdW0sACYo3WUjvNyMZ1
	 BmL7+eEpckyAS17BL9e91vK7OCdCPy8LcMRuj8p2yvAOshXD4BQx9QRNzkbrZAPqM/
	 kCEe0gdDj1Rbw/XpGtW8KjYbi0596ftn8tqlgNBNzS81tFWAF1pRaTZAnXJpZ4VRDF
	 g60SqVKPHYTPSD/cP3vWoHdg9ZWSh2D6rXp1f4UFmfBS3BVv1Cb7UKdecneEtyD6pQ
	 CqWR6gb4wZ4Mw==
Authentication-Results: imx.hfel.co.uk;
	spf=pass (sender IP is 45.145.42.199) smtp.mailfrom=newman@hfel.co.uk smtp.helo=[45.145.42.199]
Received-SPF: pass (imx.hfel.co.uk: connection is authenticated)
Reply-To: officeinfo@capitalsforce.com
From: Arthur Wilson<newman@hfel.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Collateral-Free Loan.
Date: 27 Jul 2024 19:24:29 +0200
Message-ID: <20240727192429.7A426194190B2538@hfel.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings!

We offer quick, collateral-free financing for economically viable=20
projects and/or businesses of all sizes, including startups and=20
existing businesses.
If you are seeking funding for a specific shovel-ready project,=20
you will be funded at 2% principal annual interest.
If you would like to collaborate with us as a middleman/
facilitator, you will earn 2% of the total project cost or loan=20
as your commission for every successful loan or project funding=20
deal facilitated by you.
Please get in touch if this is of interest to you.

Regards,
Arthur Wilson.

