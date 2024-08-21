Return-Path: <linux-kernel+bounces-295079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E0959664
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595ED285165
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679901C32E3;
	Wed, 21 Aug 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="U+CVY6NX"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580681ACDFD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226757; cv=none; b=keUgrYvbGaQcd6A80mQdte97KNdR8EWsBLJjoR/qIkfHeUM4JraqWAo2F71xQPSooE0wdrdRX7Uo1LZrYZmS/gAWauH2KVqJV+0qOOlz7NPnVnP78ksreOUgLXLKc5iviKluxoEKxIc0B3aySB1rvQURR1DrLeiglqwJ6QweaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226757; c=relaxed/simple;
	bh=rWbfdO/najgX+NclvzhAae3qpVHyvWxSPaRx6iJwxfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4Q23dtCxgP5EOfObNg1jNqRxx1sMGDMyuAczYsG2Mu6oltikrJUmoY3BK5r8EKaZLdRlByLYi0RhY9llgb1juzBrRUJr7I2eMjB/3BrDIr089S7QQCmOS0nhSotcVdlLf+w4NSbAwgHV5B4OnIdT7jclQdz/ULJdGp6ue4ZQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=U+CVY6NX; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724226754;
	bh=rWbfdO/najgX+NclvzhAae3qpVHyvWxSPaRx6iJwxfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U+CVY6NXtjA9ATlzGmfTizRexZlBxEzhme+an1MMa1zlN7QaITYrOoRHP2DHbheLw
	 ifNlDoI0kk85jmF7YpvSVjz8NdOsa0orTkMYrL3/AvEl9WL4nomVhj+xVg8QLCVkNi
	 JvH2K80iYvsjq7Fq9iGPbdtiolVAC+T1UmCek4gE=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 06B7666F26;
	Wed, 21 Aug 2024 03:52:32 -0400 (EDT)
Message-ID: <dab9357bd21d257f66a9f6a145570d0de61c4595.camel@xry111.site>
Subject: Re: [PATCH v1 1/2] LoongArch: Define barrier_before_unreachable()
 as empty
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang
 <yangtiezhu@loongson.cn>,  Jinyang He <hejinyang@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 Aug 2024 15:52:31 +0800
In-Reply-To: <CAAhV-H6Mh3didzHnKJiEsMP4yVgggnBBuDS1U6yDzEvdVEbGRg@mail.gmail.com>
References: <20240820123731.31568-1-yangtiezhu@loongson.cn>
	 <20240820123731.31568-2-yangtiezhu@loongson.cn>
	 <CAAhV-H6Mh3didzHnKJiEsMP4yVgggnBBuDS1U6yDzEvdVEbGRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 15:37 +0800, Huacai Chen wrote:
> > I am not sure whether the GCC bug has been fixed, I can not find the
> > fixup in the link https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82365
> > and in the GCC repo. So I am not sure whether it is time and proper
> > to remove this workaround in the common header totally, just remove
> > it in the arch specified header when compiling kernel with a newer
> > GCC version (for example GCC 12.1 or higher on LoongArch) at least.

> What's your opinion? From my point of view, this GCC bug hasn't been
> fixed. So there may still be potential problems.

I'm pretty sure it isn't fixed.  Using the test case from the bug
report:

struct i2c_board_info {
        char type[20];
        char pad[100];
};

#ifdef NONORETURN
void fortify_panic();
#else
void fortify_panic() __attribute__((noreturn));
#endif


int f(int a)
{
  if (a)
    fortify_panic();
}


void i2c_new_device(struct i2c_board_info *);
int em28xx_dvb_init(int model, int a, int b, int c, int d)
{
        switch (model) {
        case 1:{
                        struct i2c_board_info info =3D {};
                        f(a);
                        i2c_new_device(&info);
                        break;
                }
        case 2:{
                        struct i2c_board_info info =3D {};
                        f(b);
                        i2c_new_device(&info);
                        break;
                }
        case 3:{
                        struct i2c_board_info info =3D { };
                        f(c);
                        i2c_new_device(&info);
                        break;
                }
        case 4:{
                        struct i2c_board_info info =3D { };
                        f(d);
                        i2c_new_device(&info);
                        break;
                }
        }
        return 0;
}

$ cc -v
Using built-in specs.
COLLECT_GCC=3Dcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/loongarch64-unknown-linux-gnu/14.2.0=
/lto-wrapper
Target: loongarch64-unknown-linux-gnu
Configured with: ../configure --prefix=3D/usr LD=3Dld --enable-languages=3D=
c,c++ --enable-default-pie --enable-default-ssp --disable-multilib --with-b=
uild-config=3Dbootstrap-lto --disable-fixincludes --with-system-zlib --enab=
le-host-pie
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 14.2.0 (GCC)=20
$ cc t.c -S -Wframe-larger-than=3D1 -DNONORETURN -O2
t.c: In function 'em28xx_dvb_init':
t.c:50:1: warning: the frame size of 144 bytes is larger than 1 bytes [-Wfr=
ame-larger-than=3D]
   50 | }
      | ^
$ cc t.c -S -Wframe-larger-than=3D1 -O2           =20
t.c: In function 'em28xx_dvb_init':
t.c:50:1: warning: the frame size of 512 bytes is larger than 1 bytes [-Wfr=
ame-larger-than=3D]
   50 | }
      | ^

And I'm puzzled why "unreachable instruction" is not a problem on x86?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

