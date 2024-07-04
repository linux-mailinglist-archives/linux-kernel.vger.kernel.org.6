Return-Path: <linux-kernel+bounces-240406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77653926D48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCFB1F225F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB8DF51;
	Thu,  4 Jul 2024 01:58:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27A168B7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058282; cv=none; b=bAwHv9JrPOl/zVeE4R6v3xO4RSuvr6lcrYN8S9qh+qHyqAO+iJUEUJkibY9t7NoZig1rF6g5kPR/SQh/qMkICqvJjVBBh1HCWASqouRr+WI3rhZVuvc2RTKS+dIzZvz/BM4AGKgzpyivvBnOKOLa1jzBT9Zq+UChhbq4KJ9stm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058282; c=relaxed/simple;
	bh=4VRj+kijjSJj2Fdr88o6cAz3I0adkI9ew6ictpb5PGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KVYyjkbpe1fCoYfLeW9yd7SmgRrcgQ8DStcJmlD+jB8UilpzDaaEb5IOzIAv/WtStu3Vbuec7/8t+Asba62db2ibAXdak4fi1ugCtInOJM40ST9Ok7fUvp840blBtFdHGcvfZ+sOJPrlSIvRVU5Aq29HTVmLvMlYkh77D7MdUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WF06x1n8lz2CkwM;
	Thu,  4 Jul 2024 09:53:45 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BF8514010C;
	Thu,  4 Jul 2024 09:57:52 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 4 Jul 2024 09:57:51 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Thu, 4 Jul 2024 09:57:51 +0800
From: duchangbin <changbin.du@huawei.com>
To: duchangbin <changbin.du@huawei.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: vdso: do not strip debugging info for vdso.so.dbg
Thread-Topic: [PATCH] riscv: vdso: do not strip debugging info for vdso.so.dbg
Thread-Index: AQHau7U7yIu3oUXsbUGaQgARcdrle7Hl86SA
Date: Thu, 4 Jul 2024 01:57:51 +0000
Message-ID: <ef2b1430475140c88a929b1678338726@huawei.com>
References: <20240611040947.3024710-1-changbin.du@huawei.com>
In-Reply-To: <20240611040947.3024710-1-changbin.du@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5A0E03790833640B3CA9AEEE9FF2CC6@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,
Is there any problem with this change? Ping~

On Tue, Jun 11, 2024 at 12:09:47PM +0800, Changbin Du wrote:
> The vdso.so.dbg is a debug version of vdso and could be used for debuggin=
g
> purpose. For example, perf-annotate requires debugging info to show sourc=
e
> lines. So let's keep its debugging info.
>=20
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index f7ef8ad9b550..960feb1526ca 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
>  # link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>  	$(call if_changed,vdsold)
> -LDFLAGS_vdso.so.dbg =3D -shared -S -soname=3Dlinux-vdso.so.1 \
> +LDFLAGS_vdso.so.dbg =3D -shared -soname=3Dlinux-vdso.so.1 \
>  	--build-id=3Dsha1 --hash-style=3Dboth --eh-frame-hdr
> =20
>  # strip rule for the .so file
> --=20
> 2.34.1
>=20

--=20
Cheers,
Changbin Du

