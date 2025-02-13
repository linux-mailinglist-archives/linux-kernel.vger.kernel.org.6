Return-Path: <linux-kernel+bounces-512314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A021A3376C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA23A6D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A8207646;
	Thu, 13 Feb 2025 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUdH4Trm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494E86325;
	Thu, 13 Feb 2025 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425355; cv=none; b=HTsI3J/55jAcszujl99rjy7acmW2Eo8G+ed4HaRcLxK5tNRpqCQEV4T1LfCRosD8TLsrvQe+q2sL0on5+dr+o71W9fv3pwrFwJ45ffeU11/ZfhY/vulxQLQqDnaUNGdMLRuXqfDyimnoG4nDD950W3TesJ/9yXumw+WMm95vIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425355; c=relaxed/simple;
	bh=1oy+f0Vu6QrT48bg7Fr1czgxZtf91HbCjHjLvrt5GRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZcHOEy2n7aljqx8kYxfyzQ47KpjTVwBw++Y1/cDjh+MTFCyzFLGIblDAzFaYl8dVzu9+4u8TzPewMkmUn1H2ck0eyvi8jemQHWJBqxcKghR4oM7V5ddOxC37dKQri2tyAoL+CGbmsE7QTbzP6ecLDntQ1bWZSXAjwZr2fqXeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUdH4Trm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824D8C4CEE4;
	Thu, 13 Feb 2025 05:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739425354;
	bh=1oy+f0Vu6QrT48bg7Fr1czgxZtf91HbCjHjLvrt5GRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUdH4TrmU3PSPCNlyk4h7mN5QouLNiNCyFDFtazYjadLZYVLYnDXpbDAYVyzUG7eZ
	 x42pdan40CIzw19MPBD/lqCow1ApzMuOXlUG5G65r1hmlwtFbvE80XZqqUvvzAlYqQ
	 rvqH8jOtXP+MAnTYJ50LAwhm/Y8Yhyjd4FJ2MQCb4FkQ8/wx97DmzeLBqdUJt16XdE
	 Hsole4MN2PY8lj1QgLKU/k9Wc/LzDmRkcRdiueCdUq2kCpBj3nZuthGCjY7bbF+oPr
	 zHnmnl/TFzWmE141A6pEsLVUsboYKpfcJ4VurLONAB20RNvDJfTH2O0KgMgynk9TRM
	 2JlImTMW0uYdQ==
From: alexs@kernel.org
To: 
Cc: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
Date: Thu, 13 Feb 2025 13:42:15 +0800
Message-ID: <20250213054222.21776-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213054222.21776-1-alexs@kernel.org>
References: <20250213054222.21776-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

A good checked summit could save much time for linux-doc maintainer.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn> 
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 Documentation/translations/zh_CN/index.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 7574e1673180..cc512ca54172 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -26,7 +26,13 @@
 顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
 的字符标点占用两个英文字符宽度，所以，当英文要求不要超过每行100个字符时，
 中文就不要超过50个字符。另外，也要注意'-'，'='等符号与相关标题的对齐。在将
-补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试。
+补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试，确保
+在 ``make htmldocs/pdfdocs`` 中不增加新的告警，最后，安装检查你生成的
+html/pdf 文件，确认它们看起来是正常的。
+
+提交之前请确认你的补丁可以正常提交到中文文档维护库:
+https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git/
+如果你的补丁依赖于其他人的补丁, 可以与其他人商量后由某一个人合并提交。
 
 与Linux 内核社区一起工作
 ------------------------
-- 
2.43.0


