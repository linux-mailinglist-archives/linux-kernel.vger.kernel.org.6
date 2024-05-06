Return-Path: <linux-kernel+bounces-169261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14A8BC5CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CB71F22119
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9BF24A08;
	Mon,  6 May 2024 02:36:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE1181
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962997; cv=none; b=I2VX6xxYKipt90+SsRGhZkaKxGJ5ZhS/2BGzPL0h3V1pOI4dAyRl23idHvcFtWGYodlL5CvpGPp947xghm9QN1GG3vaoKU1sp3HwcPelBXO9afzLBeWldhJePIOQe/0hQkCyCFsTgnkXRBcM0m8pa1JZipDi06lh1JhGqFGPruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962997; c=relaxed/simple;
	bh=hL5W3myfk0UZm3Gw2KTvWBL+g08d2qecIGRgiwM+xqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoQ4bqgZfitMdCHWcvIZ2opU0JSCnaHF+UWI8izRLa2qp8Ua60mVcnDrAsxJ1mSQwQpOIACjJ5QLxintjwOsD3Gld62fC2dRoK+iz81BcyJ+hucqfBZdF7aZzcRJL+1tYNDc47Q8Lbo3VhS2buo22UU5tI2qsKxKMORrR5g0mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6b988a1a0b5111ef9305a59a3cc225df-20240506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:97bb32d5-6490-442e-9d78-1905402d49f9,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:0
X-CID-INFO: VERSION:1.1.37,REQID:97bb32d5-6490-442e-9d78-1905402d49f9,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:08ae3b8ca9d56691c3a6abca66cc108f,BulkI
	D:240506103620X8ARMQ2P,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 6b988a1a0b5111ef9305a59a3cc225df-20240506
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 72075571; Mon, 06 May 2024 10:36:19 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 7FEFAB80758A;
	Mon,  6 May 2024 10:36:19 +0800 (CST)
X-ns-mid: postfix-66384223-390027262
Received: from localhost.localdomain (unknown [10.42.176.164])
	by node2.com.cn (NSMail) with ESMTPA id CCB35B80758A;
	Mon,  6 May 2024 02:36:18 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: fix CPU stuck due to the taprio hrtimer
Date: Mon,  6 May 2024 10:36:17 +0800
Message-Id: <20240506023617.1309937-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000022a23c061604edb3@google.com>
References: <00000000000022a23c061604edb3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git  master

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a0d54b422186..2ff8d34bdbac 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -104,6 +104,7 @@ struct taprio_sched {
 	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
 	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
 	u32 txtime_delay;
+	ktime_t offset;
 };
=20
 struct __tc_taprio_qopt_offload {
@@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sched_ga=
te_list *sched)
 	return ns_to_ktime(sched->base_time);
 }
=20
+static ktime_t taprio_get_offset(const struct taprio_sched *q)
+{
+	enum tk_offsets tk_offset =3D READ_ONCE(q->tk_offset);
+	ktime_t time =3D ktime_get();
+
+	switch (tk_offset) {
+	case TK_OFFS_MAX:
+		return 0;
+	default:
+		return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
+	}
+}
+
 static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktime_t =
mono)
 {
 	/* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
@@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct hrti=
mer *timer)
 	int num_tc =3D netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch =3D q->root;
+	ktime_t now_offset =3D taprio_get_offset(q);
 	ktime_t end_time;
 	int tc;
=20
@@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sched(struct hrt=
imer *timer)
 	end_time =3D ktime_add_ns(entry->end_time, next->interval);
 	end_time =3D min_t(ktime_t, end_time, oper->cycle_end_time);
=20
+	if (q->offset !=3D now_offset) {
+		ktime_t diff =3D ktime_sub_ns(now_offset, q->offset);
+
+		end_time =3D ktime_add_ns(end_time, diff);
+		oper->cycle_end_time =3D ktime_add_ns(oper->cycle_end_time, diff);
+		q->offset =3D now_offset;
+	}
+
 	for (tc =3D 0; tc < num_tc; tc++) {
 		if (next->gate_duration[tc] =3D=3D oper->cycle_time)
 			next->gate_close_time[tc] =3D KTIME_MAX;
@@ -1210,6 +1233,7 @@ static int taprio_get_start_time(struct Qdisc *sch,
=20
 	base =3D sched_base_time(sched);
 	now =3D taprio_get_time(q);
+	q->offset =3D taprio_get_offset(q);
=20
 	if (ktime_after(base, now)) {
 		*start =3D base;
--=20
2.34.1


