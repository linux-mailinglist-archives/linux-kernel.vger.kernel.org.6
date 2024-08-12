Return-Path: <linux-kernel+bounces-282675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274494E73E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D26CB217E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6A51537C8;
	Mon, 12 Aug 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMfNtv2b"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BE14A4E0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445777; cv=none; b=fCm0PFtsoST+tNCyen1jaUz3AZi8+xMyx14I8u0b8jVbLXtOkXhOp1g4FNqNOgW84tEwDL8goPMUYCq5OIJzCWFOrKV5V4EDDQh4urRPWbfAnfAoqIOwVR/lFkntsf4kSkO9Xic2jA8eWdJLKUdIFKk5gP8PaKdTuOtWAjRaLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445777; c=relaxed/simple;
	bh=QzsSh3ktq3UpJh1HnSNSrph3wkq7SkEV1BWUvk416dI=;
	h=To:Cc:Message-Id:From:Subject:Date; b=ACYbCvcnJm7Or7g7L2T5d3evThz1CT8tk53vlvyHISrNxCkM6dl/mCkKM1U/5IJadzvaAMCRNTH7HxxItAX7Ixig+ZBTnLT/GhbjUQemRu5Eanpi0+/pRw+SZ4gqQn1RByVIvC8aafWsnyNAdenHWRhcXwz/Qr+Pjhzzj6Mgw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rMfNtv2b; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id B1434138FD1F;
	Mon, 12 Aug 2024 02:56:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 Aug 2024 02:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723445773; x=1723532173; bh=wgdcpDta7uviF
	pHOi0oLjz9iumO7bO5FMcWnq7HSJsI=; b=rMfNtv2b59YtdaOgDNLMvvrOOOOZy
	NzpP2mKTcV2ykL9ceilzJtEn4lv1OvHw0ypgnmGNGRPMhCWziVl3Xq4EU52qBE3t
	8s/ioU9GhHM65o+eGTE0I4c5YYkYeLJmopfUoWTRNCcD7NiZ5v6gV/uNIBKUS31w
	sSVeHsFFZKwRn9vXlSUK09odqywMHHHYT2ny8CWJvGBCDbHo3omIzdiiHhE/K6tj
	YcLyEWRFUs5qfTaSPjWrdvKXR/xIpKOq0GQ/3gPaBwE4nJtaULBz+bZdj1Lvlr4/
	1UY3pt9jGJtjwVVHifshWFHi7Lhf+PCPH5mJV5yOTfqCivtQHDbpxkH5w==
X-ME-Sender: <xms:DbK5ZqqQ9xHXyMfwJYdHCFnKUz-Nv6vOA5Hs0TmV1nCrYRr9v19HhQ>
    <xme:DbK5ZopwDyO1QRp7Zv-JpKWYZAG3JOacUePJ3cLwL0Ss0bKHXn_hS0Bd6NGzDHaeW
    QRuRH8iQx6WR5zApk4>
X-ME-Received: <xmr:DbK5ZvM-Ry97YyZwtd2TUzmkeJqipoQQYkbyRSlbjFKuhyJB1fu-FsJJ7mSCn0IPAP6ow6fgS-nQYl0dUeEMNhCzRBItw4PkcO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhm
    pefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqe
    enucggtffrrghtthgvrhhnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffej
    fefggeevfeeuvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgvggvrhhtsehlihhnuh
    igqdhmieekkhdrohhrghdprhgtphhtthhopehfuhhnrghhohesjhhurhgrihdrohhrghdp
    rhgtphhtthhopehushgvrhhmheejseihrghhohhordgtohhmpdhrtghpthhtoheplhhinh
    hugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DbK5Zp6Lyyq8kwwZnMbAjDHcMmotg8OU3MZlwAeR4fKd2IEsdA_pwg>
    <xmx:DbK5Zp4qBg4JDpR-gnN6FZkSV6dC-gLg59na9oWij11exThk61zjaA>
    <xmx:DbK5Zpi1eFE73oP6TMA69CrPnjkGabzmBPeuWe-q_G8ffwQ3cY5cTw>
    <xmx:DbK5Zj5zSc4sj3zk7Or7jNZGuTtBtr_ega_hM-NFRg3lLerrRNmLEQ>
    <xmx:DbK5Zs3r8rTj8-ug71LGFHLParvaBTfNxAlLIHf9bpx17WpmNQ0Fd8ZH>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 02:56:10 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>,
    Stan Johnson <userm57@yahoo.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <3633d85c51d2133622708e5b0e07cfea96fc295b.1723445731.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k/mac: Revise PowerBook 500 series model name
Date: Mon, 12 Aug 2024 16:55:31 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The PowerBook 520, 540 and 550 all have macintosh_config->ident == 72
because that's their gestalt ID in MacOS. Hence, Linux describes them all
as "Powerbook 520". Change that to "Powerbook 500 series", which is more
accurate.

Cc: Joshua Thompson <funaho@jurai.org>
Cc: Stan Johnson <userm57@yahoo.com>
Reported-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/mac/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index e324410ef239..6a74a3fecbc9 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -677,7 +677,7 @@ static struct mac_model mac_data_table[] = {
 		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM 2 */
 	}, {
 		.ident		= MAC_MODEL_PB520,
-		.name		= "PowerBook 520",
+		.name		= "PowerBook 500 series",
 		.adb_type	= MAC_ADB_PB2,
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
-- 
2.39.5


