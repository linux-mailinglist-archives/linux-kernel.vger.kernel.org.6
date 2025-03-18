Return-Path: <linux-kernel+bounces-565646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D715A66CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C23C19A1BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BECB1DFE23;
	Tue, 18 Mar 2025 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="STWlnEc/"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D51E5B8C;
	Tue, 18 Mar 2025 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284109; cv=none; b=H47NTcupxdC6IgeRFzWN/GO8FSSnBjZE2+yl+QKTtKO8nBkYjm0A7YWAwVy91ZDGyDJbq8kApET0vZqPoMGeEygvnqyBX3QzY5kik4p3+fi2WHy4oplJxtIdFUT0ZHvTn0jF9nUNKBhAPh4Hza4JLeJOGSCJUiKPlouhs7XOl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284109; c=relaxed/simple;
	bh=PiTmRzbTygWH1lLN0blb1/x2kmM+fyMCiD0dtvyVriU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kB1b3xa45Ye44XLZDEB3jN5b1q36iFuUaA9BlC1kw4C6SNUAQbREa6iUUY0X9dTmudQPfNkRNk+moueqHdVCXu8ArR9d0Al8flk3rGwGFmAB329uh564O8gQ8MdaGmVPURomfF62OyPxEUK/I6s9nSik7iwQGTyGtm0G7+N4gyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=STWlnEc/; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742284034;
	bh=fxtfU5VJRnJzZUAvhJzy3Ea93trYsTtSrjDniPVubhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=STWlnEc/yEsCVBZvnYHlVn1OmJAmt1qJYwB1Q0K0ma9kfJ8296bl5Er24LdqQR6Bl
	 VuGLCucMQUgngN9rWsafd2wLFEfJXlOOuXNTZwpJNWCB2xTlmGjwfawbbzgMuB3pRm
	 vowztSgO70j3Mx3Tf5dsfnq4R26yp+mu3FloPNcU=
X-QQ-mid: bizesmtpip2t1742284023tvs5xyy
X-QQ-Originating-IP: A/rClot4DoAeHUjd/IqQnETxzddDYCW2UZntEibBBFk=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Mar 2025 15:47:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11619654860580283103
From: WangYuli <wangyuli@uniontech.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tom@herbertland.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Sourcery AI <hello@sourcery.ai>
Subject: [PATCH] docs: networking: strparser: Fix a typo
Date: Tue, 18 Mar 2025 15:46:56 +0800
Message-ID: <A43BEA49ED5CC6E5+20250318074656.644391-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MTnTJt+VJFdIYTyxa6XNXwKJrIhAlJdsRBYSfGptcYqxgRmnw2Ov1kq4
	5GnBg1SHgkckeTfslaCCjEGHxW/TImJ1dB3PPSf+BdZeFfW0tdhfi1vOIu+zp1IvyDaesLq
	ux4yGtOfDDUyvSucqodJNnxCObasm3NKsa2JvL+3EPQLuaeDENlYNa+ywBY7lmizGCn0neY
	vgOfPWEl++kEKCpl8ce2eQrzx03bfeM/KWdiQNVKQ4R09TcroiV1/yz5/BuuRmQZIFuBTCk
	8Eod7QmsZH4IItQj9cOcQY/b/IpczSaMxhDbf3YIIEjRyhsVVGEmxbTb6Z2S8Q6RTlY6Iz4
	0BtOWIPqTXe4BTub5ET9gPVAf9MjnjMMSKlYaqzA+j9A8GeYMbcf4wMEnZuOb4MHJHq5Zx2
	rty+pRa7yEYgkYVvR/y3802S6M3FyA8/hMyQd6WkvkBadN9QT0069m0wWG7WT09ci4/RvOe
	y3Iii/FTBxRZNL13fpeHANGIdK1hUOSnFEjuf25N8RwMJqixySr8pARM50W2b+bxnDTk+iG
	+3BZ0TJeEuGUluzEoKxPUDb+3j9wBOkfVRKN5iSO4xruZb2jfuSuMHDTqa+OaQk4GE4oxnW
	M8EOC+1p/JMvJDhm5i7e29xPeM83gMz/3WAHuDbtQ8res60WtRU6b6zPpBadjawpnfV6L5z
	lL7jv057Q1LkFMHlYcN606yTLRBx9kKXATwRwIxnnTq6PagPsH6CHcNNvR0P/lg4YnSN5Gi
	orYQ21c5T4p+9cHx7soICHZ8VDxDikEpV3OLZXYhpDbgWdn/7C/7dqMwU3vBCYztsYioCZr
	TDASxYZES3tgLXeiVusp3nnFAKpXDt337CC+R2kDssdYdkvtkR2mEuiB5TEj18nTGTt0XJ0
	bcbAzBJUWlDclJ5/IlM8OXYBob0U0oLSjfbNKVfHqMAZtWyXFOe8GZiYGAu4jRJ9xhX4vXE
	9y88GzEdRzZ3KmzGHEa5S9x4KWRRlRD7yKEsDnMr4+BELnktlyse3nTnRHKJ3Nhv5OCV2d9
	zw3OCm7aM+uvh6PAtf
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The context indicates that 'than' is the correct word instead of 'then',
as a comparison is being performed.

Given that 'then' is also a valid English word, checkpatch.pl wouldn't
have picked up on this spelling error.

This typo was caught by AI during code review.

Fixes: adcce4d5dd46 ("strparser: Documentation")
Reported-by: Sourcery AI <hello@sourcery.ai>
Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 Documentation/networking/strparser.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 7f623d1db72a..8dc6bb04c710 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -180,7 +180,7 @@ There are seven callbacks:
     struct contains two fields: offset and full_len. Offset is
     where the message starts in the skb, and full_len is the
     the length of the message. skb->len - offset may be greater
-    then full_len since strparser does not trim the skb.
+    than full_len since strparser does not trim the skb.
 
     ::
 
-- 
2.49.0


