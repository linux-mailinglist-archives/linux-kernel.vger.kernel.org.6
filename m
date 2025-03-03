Return-Path: <linux-kernel+bounces-545074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0AA4E8B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E9F421D48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C426A265639;
	Tue,  4 Mar 2025 17:00:14 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE6259CB2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107614; cv=fail; b=WO0xQTKlvrl0l0y7cDHhDSIymNQrIqZY6rVcJKo3m3/GQcUKLvnM/WP8s3V5UCCN6QapfjnhvrdPu5f9Tt/cD+njDgb1wYUFIoAFZBXaEkxBxpC9GgxF4kGZ0d4zqltJnTGKeBhxyjrEl5ORatZGzoiGykO9R4lQeMxh6EsbbiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107614; c=relaxed/simple;
	bh=CdYtl5r0Do1A/pRmLSyGLYHM6m+tpjACuP/am8t3oXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0G2vuu707l1Ig74KwJVJcPCZdlj1QDd0p/EI7rO2eGqkjj/eotzEU5+F8EgaNeB13czBI4sDJXEPt9uiDU1l4E1+vYIbOSit0anycj2t+ztrYd7ZoSjbIedJVOGtyLan4kPWg8UVvc/BWK8LkX1s+PHp5WzNPqNIsUu87OYxYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=222.66.158.135; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 1631240D977F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:00:10 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fRl52K0zG00V
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:17:07 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C7B934273C; Tue,  4 Mar 2025 18:16:58 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541443-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 630D9426FD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:55:43 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 39A0A2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:55:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5581894137
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B71F3BA7;
	Mon,  3 Mar 2025 10:53:33 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B51F2C5B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999211; cv=none; b=ABlruTjvfhNB1cau7Zo80wHogBJp6VuzLQSZE3p2xt+ZldMGQ3wak6BvriXm7vvm1ixYqNdJvyy9WnZG8PtJ+L1hv1MXWj6hTjl7lLMe1K2X0lE97NmyHQHMPM0JqawjSAKn3RrEqc3rXgSZ8zrStKh84LRPgjHlEGDWaRx+zLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999211; c=relaxed/simple;
	bh=LXUxz1eAYTX+ZE8k6XJtrXpRg0wE05yu4Q6GBSQSvRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gdKydN7ho4Mv6WpMg47A0tDaguL4Qd4psqs9jFhoXjzwWxtH56ye1QW6UFB2bxiqZSwkjm69+cPNDA2eqFCjCpHUE+acrVTmES9oiVFc4dy3EbpSSb1cB5lTVmD9sPnRCCsMdbZ6dwuRwkQb4zq911U0IHtwEMI2/0eZI4D6d60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 523ArAGR091702;
	Mon, 3 Mar 2025 18:53:10 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z5wX917hZz2K8nM6;
	Mon,  3 Mar 2025 18:48:25 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 3 Mar 2025 18:53:08 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2 0/3] sched/fair: Fix nr-running vs delayed-dequeue
Date: Mon, 3 Mar 2025 18:52:38 +0800
Message-ID: <20250303105241.17251-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 523ArAGR091702
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fRl52K0zG00V
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712296.41833@Msg4yLAQ++W7L4SpeowGCg
X-ITU-MailScanner-SpamCheck: not spam

Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until it=
s
lag has elapsed. As a result, it stays also visible in rq->nr_running.
However, sometimes when using nr-running, we should not consider
sched-delayed tasks.
This serie fixes those by adding a helper function which return the
number of sched-delayed tasks. And when we should get the real runnable
tasks, we sub the nr-delayed tasks.

Changes sinc v1:
- add cover-letter
- add helper function;
- add more fixes

Xuewen Yan (3):
  sched/fair: Fixup-wake_up_sync-vs-DELAYED_DEQUEUE
  sched/fair: Do not consider the sched-delayed task when yield
  sched: Do not consider the delayed task when cpu is about to enter
    idle

 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 10 +++++++---
 kernel/sched/sched.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

--=20
2.25.1



