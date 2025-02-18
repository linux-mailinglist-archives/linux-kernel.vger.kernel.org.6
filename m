Return-Path: <linux-kernel+bounces-518780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F103A39473
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC0E1893DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B4B22A81F;
	Tue, 18 Feb 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="Z2aH6/8C"
Received: from va-1-14.ptr.blmpb.com (va-1-14.ptr.blmpb.com [209.127.230.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D222A810
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865778; cv=none; b=cBB+uefCVvqjmijfgolG66QuzF1HsmJdXorFb1RkdS5PY+NzJDph/ZCGbo32uTLSYnrM1+lDvLEIHD07djbbs2hkCwkn5cPfjGR5nmUxQEB/FJEDGhD9X/rwUnM5+AdRX+d7IA5iK/MKUqWJEcVQM7Ip4YShZ0CZICU/2GfcuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865778; c=relaxed/simple;
	bh=MMO+Pgdg8WUeZitp0y2WePnN5QHq5BURFZjY8A/MeFs=;
	h=Content-Type:Date:Mime-Version:Subject:From:Message-Id:To:Cc; b=U6o7cwqzQe3G6rMeheMi0c1atcNQezeptFeKqVtb9YT7U62By2dErRHeFGTz10OT10Dp7La8HehhDcj+Zaa0LzyumYMjI+VK8neyUe11U1oCxL+a6wBpmVASb5oB7gTSb4ITrdIZztw2z0d+LSFjgKOlUBrQefOEeA5n30JGOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=Z2aH6/8C; arc=none smtp.client-ip=209.127.230.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1739865627;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MMO+Pgdg8WUeZitp0y2WePnN5QHq5BURFZjY8A/MeFs=;
 b=Z2aH6/8CrVCpu9NtMyfc9p0Q5oAdZWHEBbQYGKCrg6wQR3tVN3hiIRpT7CclZQiYu9H8A2
 a2UGYxq4on4qGPxKSUOexkslLkeDC6W4cpTDLZfEKgO7S2WMxtucEJ9FehcVGtmFjeAiYN
 kjG4l9CYzaagPWUqDJkyEkQ9DPXHrI+B6KEm4hUKVHz+eQMHxcxtS6eLACjTw5nT4WCo0v
 zID8WhTSDTLXp0CsEnlRlcEqOJZp00c+4+MmRAmE20rlIGs2vL6e/HU8WOjCNB1RDShUpH
 12+4ZSwWTuHc6Z+xKOJRZsCkzzCizyNxg2zvDFz9Nfjf0/9kH05i/p+46ay2dQ==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Feb 2025 16:00:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+167b43e19+1b8d4d+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Subject: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
From: =?utf-8?q?=E9=A1=B9=E6=96=87=E6=88=90?= <xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38cc241c40a8ef2775e304d366bcd07df733ecf0.1d66512d.85e4.41a5.8cf7.4c1fdb05d775@feishu.cn>
To: "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>
Cc: "anup@brainfault.org" <anup@brainfault.org>, 
	"atishp@atishpatra.org" <atishp@atishpatra.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From 30dd00f6886119ecc5c39b6b88f8617a57e598fc Mon Sep 17 00:00:00 2001
From: BillXiang <xiangwencheng@lanxincomputing.com>
Date: Tue, 18 Feb 2025 15:45:52 +0800
Subject: [PATCH] riscv: KVM: Remove unnecessary vcpu kick

Hello everyone,
I'm wondering whether it's necessary to kick the virtual hart
after writing to the vsfile of IMSIC.
From my understanding, writing to the vsfile should directly
forward the interrupt as MSI to the virtual hart. This means that
an additional kick should not be necessary, as it would cause the
vCPU to exit unnecessarily and potentially degrade performance.
I've tested this behavior in QEMU, and it seems to work perfectly
fine without the extra kick.
Would appreciate any insights or confirmation on this!
Best regards.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
=C2=A0arch/riscv/kvm/aia_imsic.c | 1 -
=C2=A01 file changed, 1 deletion(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index a8085cd8215e..29ef9c2133a9 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -974,7 +974,6 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vc=
pu,

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if (imsic->vsfile_cpu >=3D 0) {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 writel(iid, im=
sic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_vcpu_kick(vcpu);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 } else {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 eix =3D &imsic=
->swfile->eix[iid / BITS_PER_TYPE(u64)];
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 set_bit(iid & =
(BITS_PER_TYPE(u64) - 1), eix->eip);
--
2.46.2

