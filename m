Return-Path: <linux-kernel+bounces-369126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2B9A1945
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177F3287C08
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B129346434;
	Thu, 17 Oct 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ffZbYpSv"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7B8F6C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135299; cv=none; b=PD9El3YJlQb3oUne8j3OWGfBWc2NOpeUxfMIr2q8kX8rPABO2DPNx5vJEdfzfkOQ6aujsnsZvHl/Nsu8vEzImWjCk+24W0e6B/CPlL12ZWrFBXTmLmjqghiOqhISLEXQYoJZfMsFOcGmOkgAcJAcRFhmCs4lsNPj60+L7aF2U84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135299; c=relaxed/simple;
	bh=DGxeJgemhoDo5JKQYPlnG86DMJLcCfAUQs0cO+BoAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEyi2E2uzosqpsM2rOeFvWtGSqucZbi2BfSVS2o4mO4ykdSSglOhbdSK1nBYy3CTDhE3+WOfWFlzjecSHTLOPp0OeBKo+XUk9d1grZvkYg2bzRgO5KXF1FCGwgU/1MNuvDHWYFDLfh0r+qxN/qpTr56YlsLEsFB+Fe9TA8ZF+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ffZbYpSv; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729135254;
	bh=SgCHUiz82lndKjTeNsmeInw+/PdasPiFZ+8EYbiHHVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ffZbYpSvS8Jeg5L2XjXqOGZxpzP0Ky2AfREgY3cmpIdME8mtZ4mTgY5Q0WJfWghlE
	 zSwQ58r3XY8eFHDEfVEU0e45HIRM95cZVlQ32eyR/w2L9g0BGcx5+IBshLWkPmI8cr
	 i5/i98Q3GstpB1AGnd5PT2et/Qr/i/++Wbdlgpsk=
X-QQ-mid: bizesmtp90t1729135217tx872kpv
X-QQ-Originating-IP: T+ZWv92ZAhy3mBu2f6pTzPydIDKegYzrt3xG8YNpoGw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 11:20:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6572493434624532531
From: WangYuli <wangyuli@uniontech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	conor.dooley@microchip.com,
	charlie@rivosinc.com,
	macro@orcam.me.uk,
	palmer@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	atish.patra@wdc.com,
	anup@brainfault.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	mikelley@microsoft.com,
	oleksandr@natalenko.name,
	deller@gmx.de,
	gpiccoli@igalia.com,
	apatel@ventanamicro.com,
	maz@kernel.org,
	kernelfans@gmail.com,
	jszhang@kernel.org,
	daniel.lezcano@linaro.org,
	Alistair.Francis@wdc.com,
	atishp@atishpatra.org,
	dwmw2@infradead.org,
	mark.rutland@arm.com,
	sabrapan@amazon.com,
	ross.philipson@oracle.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH v2] riscv: Use '%u' to format the output of 'cpu'
Date: Thu, 17 Oct 2024 11:20:10 +0800
Message-ID: <4C127DEECDA287C8+20241017032010.96772-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mw5V7KuSxHjfiED3b4wPFL9MTyFkJw89+tsHd5fA4sMtpNZj9C7SQrfF
	m56uZ/zfnzccw+p5fFerziX+TjfUWhrVLMob7ghCwipqxPbn0103GRL3KtU8PDzxZSNh+uv
	4ItCI/mglbS7w8h0psrYdoF4pWFAaZTSkZpiGr5d8QMakgtVGEzxq7YtprXNtl0SrtoYGtg
	wgYRJNWh3Z0tn2x9PJ2Rfc82UCWjL0LG2wNg/N2TmO/RPuFgp+PX6DF8PRA/GeYo50IZ9WN
	NwFpxj967a1e9AvN8PkrDgf+R9MKleuzdTVH0TPETRFjXvB8tAU9ArMpEXXF2WZAroWG5a7
	5Ci9K38lW362qsi5Of8dKW377+vbWWGO1LIRooLmfW9JPGWZ/PutghpdBYy5qC7F01kD+B3
	yYPDT3BIkySjviqjxs4DfZku+ronq0L9t1G3tDB4Fy0WK2jUKAyaiN62g/BPsrmJ4iLBxjJ
	cmYs1WKa1VjO7z0hbMa+ZZNilvGjv8mSrwSSuqVicK3FYnukQJSH3gGLHdqVkX26Zgnjlx8
	9ZJaMKaTJUb2RU1ngT+LUJnV0Sz1pjCy4kydrwf2msbr3KjFAO7P4aZGCZYQrZzMY7tFk9t
	h9HJR5xwPPvrQLoq9vuQwYCnYmC5v43c4EKJZn3rD0e4ejkmKtwH1ccfN39CCZI4lgvwDd3
	oYAVd//MBHSZuMUY0W6KdHucw5MRqQVm5FZz1RX25jI66pUjBLcn4YL6ntICR4ambHj8gV7
	3/WmWNHwYG0hH0dY/neV/oh1vgs7/flqdcXKgc13aHeGQZrjp0fx5AX/gmESUIU0RvTNs5G
	phNDUX40Gmeb8IojQ8u1h22U3z6dgNNMpSgobmuOLyVgRdG+/1bkHveeveX8BCQxWhe+xbB
	QdbosaLPTZhwo1W0PZ/XLHzpmaKR7hoZg9z1UcI/+oeevAnGo2WsQ8sXYdaCCbNwiRNZITE
	YetihQ/ZJn2w29uv1E9LQCuWvxK7p6VKoGSFAWvWeBlZyQGFNQ6JjjMvYZRq/lw84cG0aAZ
	qOOHcLZI5oqu39Pkwvhy2r/ae7/K0LURMe6Q4MqgBw86lHD7uRgesuuJMvq50=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

'cpu' is an unsigned integer, so its conversion specifier should
be %u, not %d.

Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/all/alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/cpu-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 28b58fc5ad19..a1e38ecfc8be 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -58,7 +58,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 	if (cpu_ops->cpu_is_stopped)
 		ret = cpu_ops->cpu_is_stopped(cpu);
 	if (ret)
-		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
+		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
 }
 
 /*
-- 
2.45.2


