Return-Path: <linux-kernel+bounces-235812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E661591D9F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5908D1F2235B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF183CD2;
	Mon,  1 Jul 2024 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ClWMAQEB"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B72C6BB;
	Mon,  1 Jul 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822731; cv=none; b=KhMP2nVy4/ZtAMPbWY5QkqJXH/YPppm4l2p5K2+cTqWhudemj1qWU5YHeMpCkq2i7swxSZpA4rO084QKwowyqtC3cNvKY7QfhBgc5hzgP5rujQ/hcWK9rK79ViN6LXSIqCFzydrz25kg/W05VKKXVNBaOsR0wiuN9lDRujJyooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822731; c=relaxed/simple;
	bh=IUdsk735nWH4ohHKX+66QjehMYgdZYLvvTtEapLDwQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5LqxYnwHSQLT5Yp4hJwRSommPunDTj05Y/vEdzZlP8vpTXXb+mTQes6i8bpBJpNcoj6NthwUK8eRi4sxiIWnfLTkm3c/9gWylcBZtdmXn0qvrBU9+x/nrL6hlFSdAk4ePyMD8pbqfUBhZrR2nrAYzx5yeuiLXNiL+QE6M7kP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ClWMAQEB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719822722; x=1720427522; i=deller@gmx.de;
	bh=xk7lwGMPnXRzLW+IrNcY99uL3kG/731SfWWT48az+rk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ClWMAQEB8wHJEcaN3JYvqtvwnAWaIm3BEWrsKh0GHKDcgVL5hthAc92u1Qu4/f8I
	 CmoPjcQMRBA5BZFwRqNCCUxG6VOf6y+3QiLGcoW5St5JtRw9jncwrw0LNEhIO6Xnf
	 cbRwAjUBqFA+uKU3qFqI4aNeE8sZ4jwPecO5NgUxMHcNw4rccudCThaliQgMgmPpC
	 dkoM8APAMnY4YlGNq9XbJoZkg3kjgBiQn+EaRzDZ11jFcN3vPNvkGMOvS8rM/EV6K
	 EQt0iV8X4lpCreZEC7DEF84O/D4CFT5EFxsPTi8fClU8mGb7u4Ps1tuHqdY/t6jsA
	 m2C6ihYu2TO9NtJe1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.78]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmfo-1sq8fw1y6E-00TtCc; Mon, 01
 Jul 2024 10:32:02 +0200
Message-ID: <fda9f296-8c4a-4224-84c7-2efca972ecb9@gmx.de>
Date: Mon, 1 Jul 2024 10:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build regressions/improvements in v6.10-rc6
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org
References: <CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com>
 <20240701072703.2941315-1-geert@linux-m68k.org>
 <bb1acd5b-1a20-646-8d99-12dcfa899c3@linux-m68k.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <bb1acd5b-1a20-646-8d99-12dcfa899c3@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nFTuEYNhOmcQHX11ELveZCvGEd4BLi5kZaSipVDP1aIYucKCCdw
 u4xE08y4+nV4b89ocaqPd5m2ncMVB0ruhnGKbR/xtIevY2vt9bclUEYYugpDQdU9MXLqEWy
 Yk4icmKh2syDvyqwcmuvy7Pz1rXJfS1WRcK29PssUwL5SSJKEbP4DWMb3Vlg34MFpuR90p+
 TzLvXPrcqWt+uLlJBCcRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+yiWp/PWLKc=;8KF0JJXMEawN1Y2PBJlJfLDEDh8
 xzulFj59J91t+60F8M/+m7u+XN8CAX9TTOgslzASE7pQzIPH8FvHN2TGxBt96mf9UKeoeNRvm
 r2OgSDE9Az7FqT8bN4yTWhkMyLBfncLpd6apAtTJ3EWvnvubd1sNfPpVQap6KbkV8gP9Lgtp5
 C8XeOBAdnkgfJhAI2BT4JdgnUfV4uSRWEAcF+swxr4L4SzdpsfA6DJ47lvlGM3UUpsz5zKCwy
 84s+ngyLTqJ9dOHJYLwo7SeZR9q6hx7tJf0ijdycsQFtuDNcKBYBcqiNo7MEJiMZLHDgX+A56
 MPaNNaz9D4pWaLgzvdkinAL5nQ9rRKZp6ud6tIFXLfiCZY1ARcbIsbd9K0kppD2EErweEsjgT
 /6LA+Utgy0J6S57JvduEBFZ+KARBO3gedZzpSEIR2dJOKzGjVu7JPKUahrfd46CBFCJ8oM1u0
 q9+TMR5pxjNAN9iQETZjQBl7xty+Oqeil9Ig4C7SpnzEUB3WUuYeKwZ46zH184y7CX1cQMi76
 ltFyJ65u28QOdyKRJrggWY+9+r74biSOcMwG06A8R9RJEcTvwqEi6FdwVHiJPyLz4FBhRkEzW
 NY/ukW4Y0Yh3Fu6PwVT+lGvZVSrbEAH0vtE8xCEnY7n47yjjmqUL5CciwBUkfxas76D6EqQn3
 nKTbdBOapir1y9D6xeqfiNONcHC/QOdINgANHc5Q/z8Ewn47zrJ04YkDKDyTSNKivtHr1kpV6
 Ur4imsbCspjjsq6LaMk3vk0BwE+RyDTSp3odLxYlLvcC560c3Gy+wAEDBboG4kAKH8qHRPYNP
 Wo5AGBIHOvdEPLgASEPGiO/w6xURX5Sg+cayJ0wZ8Z+00=

On 7/1/24 10:02, Geert Uytterhoeven wrote:
> On Mon, 1 Jul 2024, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.10-rc6[1] to v6.10-rc5[3], the summaries are:
>> =C2=A0- build errors: +1/-0
>
>  =C2=A0 + /kisskb/src/include/linux/syscalls.h: error: conflicting types=
 for 'sys_fanotify_mark'; have 'long int(int,=C2=A0 unsigned int,=C2=A0 u3=
2,=C2=A0 u32,=C2=A0 int,=C2=A0 const char *)' {aka 'long int(int,=C2=A0 un=
signed int,=C2=A0 unsigned int,=C2=A0 unsigned int,=C2=A0 int,=C2=A0 const=
 char *)'}:=C2=A0 =3D> 248:25
>
> parisc-gcc13/parisc-allmodconfig
>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/22a40d14b572d=
eb80c0648557f4bd502d7e83826/ (132 out of 138 configs)
>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f2661062f16b2=
de5d7b6a5c42a9a5c96326b8454/ (132 out of 138 configs)

Arnd has already queued up a patch to fix this.

Helge

