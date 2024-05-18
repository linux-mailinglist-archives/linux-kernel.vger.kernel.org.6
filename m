Return-Path: <linux-kernel+bounces-182907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14878C9196
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789A9B2119B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD1D481C4;
	Sat, 18 May 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GGT+svEr"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27047F41;
	Sat, 18 May 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716047887; cv=none; b=t7CppZQo/ajI/zcRb4BfYkw5SCGuKNrPacrjxAvgjZg/IBkTSpE3JKGE3czqYtgL50FeCfN+04id29dQ32FdjrC+y25/beuJLuGbou0DzKvGIoOZhrR70bo1gDOHA9SY3ht02hZiOrsP/XIqgGb0fs1mNHrOK0GQCdJabFqMRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716047887; c=relaxed/simple;
	bh=T0B0o4Ahrip8acK9zV6qCGZ5vdii8VsZwX5YTddlLXo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=rLzzzSUktcYVqdHz0kXYRkR0TvD6Xb+3rIcIKDgvBDpPyIcJf9xqL3tkkio+BAZzP6WuEuCrA1JhdSXpMCzEZ52IgrQlrFf634khceJe/li+nl+PG03JDjwN0uE5dtQ4boqmMxM10H7JbD8aSkrz/dgUuYnBRixSl6sVOgWiH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GGT+svEr; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716047871; bh=tAscGdrOoDFuMMheeDr7p+FqOHBXTQvTsOI3LnIgptI=;
	h=From:To:Cc:Subject:Date;
	b=GGT+svErobVJZ9z26eiVNtR4Y6gTBka8K7cVS2rCPErFlJYbZlMOa8GHsg7yKegNg
	 ZDvD4Fn5gezQ3yO28YgTuh4ajfGEHSnoJHB6YRpqiiliuP2Z+JUL6OooL7Cb7a42Hg
	 JTAdWqvKSkC8HRNtBscCH/aXYVKueWczq5bBSbII=
Received: from cyy-pc.lan ([240e:379:227e:fc00:28c6:7f50:fe33:13fe])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id E6F39492; Sat, 18 May 2024 23:57:47 +0800
X-QQ-mid: xmsmtpt1716047867td774prpc
Message-ID: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
X-QQ-XMAILINFO: N1L4R2fPZA3sGxWRvyML2lSmPDupt8TqlCjRvFnm+hC6uaH9gXe0Pm3XD0PSL/
	 0erheW3tBktAEYY1aGCsZMQ+9Km7EjyMrugsV/1l1P6crb/C1CZff/eKpC/3Wa6GfdIumsU6HVkt
	 3NZKdmpULhbB7Z1uhNU/adSopXtbLEEk6HRJ8igxn/oNXPX1mOPoWR2PHaU3b5YazgVMHIYDHNjN
	 MPefZ91iplsmyKG5OKvi97a5lTfhCRCoLnj9VNxIKlrkLs1lPwJM+gxxJ9Vmj4PhxeNohlDZrfd6
	 XCohexsFERKvzDLN695swbTQX1chHh3r5099is1qYNaI1qn12kd5Icf/G/nZyfICbcxZzES6WRWX
	 8RJEo42Fkvyj+nN3Q4ZW5FzyDOlvigGNF7OZYI7v4PvRv1Y18NaqHe3aZ/hmXnF3egReKW+WN/dp
	 cH8LEDAqI/KaCJ9AtAAifV6YOdv8lEtBPJpwq7dIGSEiEP0oWbyCptsU8f1Yk/4lIK+x9K765QyC
	 QP4mnkX1pDMR/xyDrjtYvDeq6vbcYNLXAiKVLkelPWgsrh0VEyBTUzC7+TPqcfc9i9HCnGzNRZtL
	 +uIdBB69Shyd9rIG6DWrWKrnu9tFQzvREOEbRxM8xR2622D/lz4+546WyvXa6BuPv/8Umnkp3p4h
	 8M2F+ssKMuyOFlwgIeCGKAt7RGqUXVOiNngpMDt0EYGO/HruiBz5fSdUO5KjUScmBUK3+ogvESHb
	 HV3pjo7TwfB+Ov2oNhb8G24QKviYvmn16xcaAJ41J2sA2gd1Qbg830M9VgdtcUtsJyxJRIU/Rbkb
	 RtIm8wNJtyEL39MubshwbQKPx7kkfqmcnBoiDE7miufs0yTDawZlCrV+1XNplP+ioUY2wOK9JU6y
	 +kbMc1oN/820cub/UlbrJvLl398C+L34JYi+yxh9d4RGRVLpdOyQ8uVzWom35seoxo4onN1gxdUF
	 clsrI+752+eW1IvssCTQkEl1vZiv4qqtGPyqXXJx7+xDjBxcRJcedvF6vfDp4PuIb5Ta34AYOa6f
	 n7aD+rKA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Elliott Hughes <enh@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Evan Green <evan@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 0/2] docs: riscv: Some clarifies on hwprobe misaligned performance
Date: Sat, 18 May 2024 23:57:45 +0800
X-OQ-MSGID: <20240518155745.891372-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset clarifies some unclear things about hwprobe's misaligned
performance. Including:

- hwprobe misaligned performance is only applied to scalar from patch [1]
- The defined keys of RISCV_HWPROBE_MISALIGNED_* are values not bitmasks

I cherry-picked [1] rather than write dependency because the original patch
was submitted with a line wrapped to 80 characters. We can't directly apply
that patch using `git am.` 

[1] https://lore.kernel.org/linux-riscv/CAJgzZorn5anPH8dVPqvjVWmLKqTi5bkLDR=FH-ZAcdXFnNe8Eg@mail.gmail.com/

Yangyu Chen (1):
  docs: riscv: hwprobe: Clarify misaligned keys are values not bitmasks

enh (1):
  docs: riscv: Clarify risc-v hwprobe RISCV_HWPROBE_MISALIGNED_* docs.

 Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++------------
 1 file changed, 18 insertions(+), 13 deletions(-)

-- 
2.43.0


