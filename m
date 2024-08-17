Return-Path: <linux-kernel+bounces-292766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E037957407
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134C11F2170D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12C1891D4;
	Mon, 19 Aug 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tandagat.online header.i=@tandagat.online header.b="jE3sVZ8j"
Received: from server.tandagat.online (mail.tandagat.online [107.172.211.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D57136663
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.211.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093772; cv=none; b=gzVIOMQplH79Cqn1Q4Lr2DsWMzg9P5V8Bhe10BiAFKdt50VTja3Vk+e0UlhdRw5/Av67TCbri395v+W+PLsyNbrDiWS/ZhauNB+3vTpHrPqKTBS3Ztr6pQIH2kLgGFwJk/09WGFoQQnCYA+xs94qQQpQrOEK/0pJPSFWRFOGfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093772; c=relaxed/simple;
	bh=2WoKB0pMOk3pJDCrnvE2YmsE/5AcUKy7KHYgV/Mf3m8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=axxHrR4TbyAF2YjJyQiKdWNj3+Wi8g6+Rmj4EZQclx+BJlBI3ulW5fW5toIFBsCVruS4ldRSXdF2rtuZgMs0jtk84vF3EFOo8VVGBu1083DQsP9icax+Z3i/bziBpLgXVRbQ/IXyPUV/AOCCTzi3FiChMDrQf/hqwL0peeCTBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tandagat.online; spf=pass smtp.mailfrom=tandagat.online; dkim=pass (2048-bit key) header.d=tandagat.online header.i=@tandagat.online header.b=jE3sVZ8j; arc=none smtp.client-ip=107.172.211.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tandagat.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tandagat.online
Received: from [45.80.158.93] (unknown [45.80.158.93])
	by server.tandagat.online (Postfix) with ESMTPSA id 8F0F5DCE3C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 15:58:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tandagat.online;
	s=202407; t=1723906699;
	bh=2WoKB0pMOk3pJDCrnvE2YmsE/5AcUKy7KHYgV/Mf3m8=;
	h=Reply-To:From:To:Subject:Date:From;
	b=jE3sVZ8jMWQ68+GkH8C60+Qp6kMzEUI5zH/LFoeyJ27PgX0f1fTNvCV2tTNSmIs55
	 Fae8J3AaBWylDuG0mMJQ9pVDK2CEaYp+C2f6TcGKEqrSX4K+qK8ZD2T6kM8FpHmPCH
	 168wqSnlN3koSzxohD7tQr6kPD3Uju9l04NBefXHg0WiR9Bwb54nGz/VhzXZV9rDCl
	 IQGiskk3HO6iSGwar8F3rdmHgPVwpRtgO/aGL/VfWrWoOPct8+jBTmYBfUUsgDS0g5
	 Z2J/6ABZbWn4NRrsJWdHkx9mivquufkyCo60jRNJ6i1un59ANRZXEMVabXBsQsi5yo
	 cpyYjirqL+LiQ==
Reply-To: careers.proclientstaffing@gmail.com
From: TFWP PROGRAM <admin@tandagat.online>
To: linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?TWFucG93ZXIgUmVjcnVpdG1lbnQgRm9yIENhbmFkYeKEog==?=
Date: 17 Aug 2024 16:58:17 +0200
Message-ID: <20240817165817.FA6A65E78ED8D17D@tandagat.online>
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
2. Ticket                  - Provided.
3. Medical                 - Provided.
4. Transportation          - Provided.
5. Working hours           - 8a.m-4p.m [Mon-Sat]
6. Vacation                - 28.5 days every year
7. Salary                  - Ca$20 per hourly
8. Contract                - 2 years. Renewable
9. Extra time              - Ca$22per hourly
10. Insurance & Pension    - According to Quebec Labor laws.
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

