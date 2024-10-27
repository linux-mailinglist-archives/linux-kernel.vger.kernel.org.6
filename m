Return-Path: <linux-kernel+bounces-383875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822AC9B214B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 00:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4267A1C20B4B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F92188A15;
	Sun, 27 Oct 2024 23:04:31 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B917C61
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730070271; cv=none; b=j/y8TNXJjwy8tVN8OtYKCQSfshrIUQ9KDbDSjebH+9c1NHZiMnJyuONn0sc5MDfZ27Rbx0MmEE3S8SybM9KQNCrBNxwYcyToUeX8iqEK9YBV7IxUwhE1kidM+OhsqzKeT5sQ1LTToEQh4VLhI2vfzVybXy4+qkbi4CB2r2L6aHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730070271; c=relaxed/simple;
	bh=eQ5d6JYzedEo6qgOSBefHqNWMIjTUKtho4mHNp4xUoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jw7WhdxyZzSPh7L8tmqVcgky9rraTKzuLFcdkgBhmHoIXKJpYVtGr4tTAzobKxGvrURtwFLBeoiQmZ8OTGNh+3eVEqUKrStGYVdpvQ14wJg45D+mDcrT/gCv5J1mDn4wCCVp/Fvx1cY6e9zfi9bpXQNq5uXc8TS0WH7v8fDJ8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Mon, 28 Oct 2024 07:04:00 +0800
Subject: [PATCH v2] MAINTAINERS: setup support for SpacemiT SoC tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-00-k1-maintainer-v2-1-272c9834220d@gentoo.org>
X-B4-Tracking: v=1; b=H4sIAODGHmcC/32NQQrCMBBFr1Jm7UgmKRVdeQ/poo3TdhATmYSil
 Nzd2AO4+Iv34b+/QWIVTnBpNlBeJUkMFeyhAb8MYWaUe2WwxrZkrENj8EH4HCTkGlZsOx7d5Ii
 7yUKdvZQnee/KW195kZSjfvaHlX7tH9lKSOhNN57O5L1lvs4ccozHqDP0pZQvN6s71bEAAAA=
X-Change-ID: 20241023-00-k1-maintainer-46eb3f31e6f2
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, Jisheng Zhang <jszhang@kernel.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, soc@kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=eQ5d6JYzedEo6qgOSBefHqNWMIjTUKtho4mHNp4xUoY=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBnHsb1gwt+NcWlFwWtfZiq7ZsnYJstpRio7SGLE
 ZpMeJzY8/qJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZx7G9V8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ezeEACazH3qkA59+bdj3x
 hfSM5zNIf+a9bWfeibbOEEeF/LUGt3b4420R4+KvAS/mFuFfZ31Pgc8Uc6y/ScJ6Z5nPd5IYxSC
 NlC6qHTMSBC029Te89c97shw1LH1a1WRZjylWBetAftZa/+EfVggaDDne2otMTJ8pFpL1OmMha2
 Mb4zrDxTeh0EqDEfGOHNkD7g1WOcbCMitcJx0dDRY0YHypSlTmN+EbmFAjErhGQxHqRZmyK9gXN
 yz0PnAukThSyM6WsoznQr6+VHiM3+GmEjR+hRXtjwYzVJ1AKNJkevTG8O2SrQAxxFBZCdvBTTXc
 F7Ygf3qJfVGwo/u/Ecb2ptt5XJ0WxbkGVM/l4hDKxlFXKVj4kzgmBp1DSFysfLF7t5TMG5gNldq
 TQxcTzi2qtjExq3+cDjP9pXl9b6nLozLx7rNgwbl4MI8mOAQ6Nmw99qGpoSnLdRjMy/bDKiP9hR
 GN7iur85Y2fMwKAuAvJACR0Va+OuM4QN5+TPWnhApCDVNwbzvD2Y4jnXSFlBYaEXwRVfToNZShg
 iPGxjHl14MTMuuLelyb7dWchigQu6Eahj/+boYuoxgDC7AUXtOEZChBcdexHyKmV0osVw1pvOjq
 R0VADyiOgo4dC8vi8AaLOwUfN5+kBGGdMhQBlk6YYoUqxzNSJQuxqXOUufKusSNwRuUQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add myself as maintainer of SpacemiT's SoC tree, which
suggested by Conor [1].

Link: https://lore.kernel.org/all/20241018234615-GYA2124001@gentoo/ [1]
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
This will setup proper maintainer info about Spacemit's kernel tree,
which should help to take soc and device tree patches, and send the
pull request up to Arnd's soc tree.

I asked Kevin to host the kernel tree under SpacemiT's account
on github, which should help people to get access more easily,
and promote the tree a little bit.

I could take this patch through this spacemit's soc tree if no objection,
of cource, after got ACK.
---
Changes in v2:
- drop RISC-V exclude dts
- add mailinglist info
- Link to v1: https://lore.kernel.org/r/20241023-00-k1-maintainer-v1-1-c06b791cc2ee@gentoo.org
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3347d649855992a559e3526d18443..88fe4ca801537eff7eb5001406a611ef80632b5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19814,6 +19814,15 @@ F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 
+RISC-V SPACEMIT SoC Support
+M:	Yixun Lan <dlan@gentoo.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git https://github.com/spacemit-com/linux
+F:	arch/riscv/boot/dts/spacemit/
+N:	spacemit
+K:	spacemit
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241023-00-k1-maintainer-46eb3f31e6f2

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>


