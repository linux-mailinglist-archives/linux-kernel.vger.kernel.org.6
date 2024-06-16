Return-Path: <linux-kernel+bounces-216393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC406909ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B4282A57
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE839AE7;
	Sun, 16 Jun 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rpmkZO7Q"
Received: from qq.com (ec2-54-164-151-162.compute-1.amazonaws.com [54.164.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D111185;
	Sun, 16 Jun 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.164.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558849; cv=none; b=mX3XenxpXnrekO76a1yeVma9W6jebROHMBjxvA0zJrmYHQ5qj/icQXXa3YZjB2VGY+xAKbEQEWNXiB6x+Ci32NzAUBu238p/Y5bo45JuAiijXUZE1nYoslz5UP9XFzCA6F+P73qt3UdOUWYEsicBMXlHOuOMky6mIBbtCQSAbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558849; c=relaxed/simple;
	bh=apu5GIB2gUHU9BCH1sTX01ka5SffszZCdutR8azCuZY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=X/KTLWpdbDeT3ERRDln+3WWItdM5DrLf8GxL3PgKgcJMfdM9iE09zor+miPkJAZn1E4Q49fgYF3CDnz48E8l+shbkrwd+RbMcYwpPF62Ka7p/O+ahxQAigmp2cY4Un30R/5Lq1tb5zfmo3n+S9PbQpuqhSj342r0NQWGanCKe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rpmkZO7Q; arc=none smtp.client-ip=54.164.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558842; bh=zeKC3Oe1sKju5vea7yzmfOgsaAN9lHVzkh8ycGLf/vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rpmkZO7Q3lr5poCGwegrdzxpTFnL5moPb4vvhHq8pk5XcfhVt4ttoBDOlSBf8MclR
	 TLyMm9DrUB3zoJg+/UFDKjRIJERYtSF1I255YuHkvATH45NiOCiAGsttpte/wVdwm7
	 UnSHXMMAcZfnl58KW2gkOec4Pq5YQ1lYkxlGxaPg=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5452D659; Mon, 17 Jun 2024 01:21:05 +0800
X-QQ-mid: xmsmtpt1718558479t9pmmv511
Message-ID: <tencent_CD84ADB1874F47D04EBBD51119173CC62405@qq.com>
X-QQ-XMAILINFO: MziGzrjZeogZ27NrJX86U9jmp3/uR2WhQdNN59aMjNpQON5Q8za+/F7sLh1Hw3
	 68tTGDI+4ujTQB04ciQCZIDqmk5l0FgIz7LbadCoXNVt4MbdGSzeVw5sw0p7+W9jP/tnOz1ijKX2
	 yymOGrxBVmW++5Dlp4bpZOOpIboV3Te7DvvSydWKW5hdB+f6O9O7JLb0duDWH9IwUFe1ghXevd+E
	 2p9dJzWImyecsjCIsgX3kkW14grbuplj7fdgkZuolIIpyKBbwEqG17ZFtSwGLFVkYyPe2QnUcReg
	 Nhd7VbCnrgu2Q9RCdahd8qcNgj03uFRba26bDP09Olc0sR2eQYSYzytI01/Ns4mlPh5owihYJSL/
	 G3ULFnShSV6ndFfa1lx74tipKESOiplwjU/ImPfilq2L1aeWFycQuUcio/lU3zz6eJriG9xt3yXd
	 dvdTisTuLI7XTvONtGY1xY2ExXxplOVEJRs5ODMrsD5MCcbQypY+8eCuyQqs2lUIcVN7D6YuJrdz
	 Vk0jxsvGtmNKfCmunBl6VSPgYGDPazV6MA80LcJqf/IGxD0PyOoUJeVNaFj3dq/AtpflQg5y47Ui
	 YEwJpRllMYTo77HXltI7f+RsC4hSlhjzkvGRDATwKCX3WEay91kmQkEqv5QRdj2Eu65334LgXyN/
	 6KmZP1k8Kc9+fNe4wpjR9XhqldEwx1dn0Fx3hegHJbOheC3UmJf83SIMIxX+PBMr0vp1BErH3RnD
	 jfz/a9k34ylPB8U3O8eZC8fVssocE6wWsxVCBv91Q7VB3UdxJJnlVcDrbpgGO/rwKpmWUthdmnOc
	 FUMgRcvOiTsPWQz2Klt9gl3e6Td1kmog0s5XTYzQ2dkTDFi9leD+p26OiKY+bKNqVKkNc7pcowCi
	 iTqQv/zIAluRWXikuNSH5dLzkqEr1TppMuJ1ISsJWoO16rsZQq4d/o++9ULOQ+JfXcCFb6Cu6hq1
	 TKXk8tVqLfxXv19rmC5A524t1CeqLW9xchlDewimwA+cK63EmfN3HP98gV7BMzX+MHp/1dKGOs6T
	 CQmN2bCTO2XrP3ipdtdxmzN8cDo9AljyrAmES/ev8FXRPKSwia
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 9/9] riscv: defconfig: enable SpacemiT SoC
Date: Mon, 17 Jun 2024 01:20:54 +0800
X-OQ-MSGID: <20240616172054.3074948-9-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SpacemiT SoC config in defconfig to allow the default upstream
kernel to boot on Banana Pi BPI-F3 board.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 12dc8c73a8ac..a33e8c463c8a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -30,6 +30,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y
 CONFIG_SOC_STARFIVE=y
+CONFIG_SOC_SPACEMIT=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y
 CONFIG_ARCH_VIRT=y
-- 
2.45.1


