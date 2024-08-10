Return-Path: <linux-kernel+bounces-281764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810D94DB00
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F51F22015
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9D45C1C;
	Sat, 10 Aug 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toneromala.space header.i=@toneromala.space header.b="5zK8tX+g"
Received: from mail.toneromala.space (mail.toneromala.space [107.172.211.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A579C4
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.211.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723269994; cv=none; b=s5cElu4CXeTS/x6LhV3VIHbV+ySPpsjLFzenC7TJvK1PCIVHx1sTzuUCBQk2dr9E4D5fK3Jbk57Z3HUBvV3wRABKeX4jcz17Hln+zRUGrgyqoeQH5lRRXppCEK4Qe2J2DnJ30gAFgvo+Xsuwpmy8VqwF2cJS4zlXeA+RmaPVgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723269994; c=relaxed/simple;
	bh=j69zzRH9k/nQ1IAn2woSJ6H9IVQYL6Bv5jaLMBXKS7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTePMsUZ21SUJN27rRLm55FEqt9LGt9uf96XYSnm+fRkrQO8lIamJKakgKG6leF+mKsM2WfnowBd9GeqFRDk/3WpzBmprCP8ik1P4ZlGatKrUmLPcXQORgzel+hlLRC8yQkJXOlBO/7OSBCaVTo+k+fDk9IiVO72CcnA6WU42hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toneromala.space; spf=pass smtp.mailfrom=toneromala.space; dkim=pass (2048-bit key) header.d=toneromala.space header.i=@toneromala.space header.b=5zK8tX+g; arc=none smtp.client-ip=107.172.211.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toneromala.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toneromala.space
Received: from [45.80.158.93] (unknown [45.80.158.93])
	(Authenticated sender: admin@toneromala.space)
	by mail.toneromala.space (Postfix) with ESMTPSA id B0315C252C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 07:03:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toneromala.space;
	s=default; t=1723269834;
	bh=j69zzRH9k/nQ1IAn2woSJ6H9IVQYL6Bv5jaLMBXKS7o=;
	h=Reply-To:From:To:Subject:Date:From;
	b=5zK8tX+gaxZh5u0chvz9fg2fimyBB8WAyLo9JW1C9cDpyJOPk5kzSn4MhnZbYvy2S
	 jCUi5pwWgQYk/+wl/SD2QdS1QLBZSUFn/lIyHeCnvm1Je414OLXj5lNmUN4AA2hP5w
	 9ZUCZfMD/1DZGlbptvX2sMQvYoZwEfmn87l6dN8XYCZtBMX9+6Gk4pY6+K7oXYhEei
	 mewZAKQryxrafqh+go8PImcfpWah/ocI5MiI3CDMPr+hDsdD+k8LWwBD4OebV8rfQe
	 Tr3Uve7P2rf3GyBk24tZxeY2DVJlIRYWMc3tYDeNERlF7rgqI0usRe3u72P5bbcORs
	 flPSLuBWh5Pew==
Reply-To: careers.proclientstaffing@gmail.com
From: TFWP-PROGRAM <administrator@toneromala.space>
To: linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?TWFucG93ZXIgUmVjcnVpdG1lbnQgRm9yIENhbmFkYeKEog==?=
Date: 10 Aug 2024 08:03:50 +0200
Message-ID: <20240810080350.E1DD864C27605F36@toneromala.space>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Sir/Madam,

We are authorized to recruit 120 unskilled workers to work in=20
Canada on a two years contract. Please kindly let us know if you=20
can supply the same workers as my clients' requirements for the=20
following positions. Fish Packers, Cleaners, Laborers, Fruit=20
packers, Supervisors, supermarket managers, salesman/woman,=20
Storekeeper, Ground Maintenance, Gardener, and Truck Drivers. Age=20
from 20 to 55 years old are eligible to work, Primary Location:=20
Montreal Quebec Canada.

NOTE: No qualification is needed.

TERMS AND CONDITIONS:

1. Accommodation           - Provided.
2. Ticket                  -Provided.
3. Medical                 - Provided.
4. Transportation          - Provided.
5. Working hours           - 8a.m-4p.m [Mon-Sat]
6. Vacation                - 28.5 days every year
7. Salary                  - Ca$20 per hourly
8. Contract                - 2 years. Renewable
9. Extra time              - Ca$22per hourly
10. Insurance & Pension     - According to Quebec Labor laws.
11. Requirement               120 workers
12. job description           Laborers
13. Skilled required          Physically fit
Other Benefits                Family Status, group benefit and
other fringe benefits.


If you need more information about this recruitment, please=20
contact us at your convenience.

Your Quick and Favorable Response would be highly appreciated.


Best Regards.

Mr. Aiden Benjamin
510 Rue du Prince-=C3=89douard,
Qu=C3=A9bec, QC G1K 9G8, Canada.
E-mail | careers.proclientstaffing@gmail.com

