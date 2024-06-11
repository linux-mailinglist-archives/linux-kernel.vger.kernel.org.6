Return-Path: <linux-kernel+bounces-209458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53C90355E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A0B1C203B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C43174EE3;
	Tue, 11 Jun 2024 08:16:45 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98318643;
	Tue, 11 Jun 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093805; cv=none; b=slc2lzrIVD2n+h5h+3ABcm+g8GKIEQ+yaPnX8bTKhJm+zY5LgnqTQBdRsrqLIeMTJr9jDdypHqPHCGgHVumiLa0FIJ0S7bdXux8m9iTTULZk6aZXfMK2qesV4GgWd0dzlODuwlO/tIZZONhmR+aKMnz++e6zHLMUdNMycZzsffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093805; c=relaxed/simple;
	bh=zJJ45T+EkNxfJ1lntg1XIT+bWbsPNOtek2btucIw8dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js82FruHYhDpnbcm8atC0XeY4JMQL5bVBFj8MUAKVjykcObpmiXa/PmyF+ehzQ+gfublEsUXbgH3/g1Ft1K3UjoywTSoHO2bqJqgdGQbdatNySXBCh2mouIMBlFEbboKXo+PvuEJNoMWRyPxZbS5BLhPRZiddxF21QgBPB34eN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2eb98a64fso2131616a91.2;
        Tue, 11 Jun 2024 01:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718093802; x=1718698602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6g564VKiL0eMr15/61Xj8es8OXMxMV9Cr2DrDtu5sA=;
        b=BiluWINgr5OB0XMp8KRAldJcB15dvn/AScAOY+Kjy3ZhIJMBsMejLf4ppJOL6AIdc0
         BQ/Lu/R1fi/IE9Pw+nRT534nSeNEcy7KjB/6v3Swkfk1xVZ4CmsmL9Hx1e2RDOk5xRsu
         QW8ygOHsnnuOJ+F29EJAUxna2GAolMd6Xm9X087iqG3pUgyrfxqa7J1wWdmM6lp03QLl
         Vf2bYZbUrVERsrguKiWdg638HKnP8fchYfq8TWH8gbJBWQGCZvL+dzKfkrDodo2QJ5jO
         l62jiKUKryWAVjwGR7En+hNjUNVqkuux8r0kltdGGDwgpLEf8FQqX7clkkFcZJcJtoDc
         Hyuw==
X-Forwarded-Encrypted: i=1; AJvYcCUkAHMkpZ+rSPNu7ZsmuZ5bVwStY84R+w/UBe7kWTX5c3SapFBSpSQexYu7yRjFCtfb6mZiA2YIDANqclSDNw5z3X5iww9biBIzUkHAtcbNfJnlLMqIQJ+ywkrI4R4oC41ii5wv8krv
X-Gm-Message-State: AOJu0Yz87xHZXeYmyEAnl5tLf8+gQIvwuRXGTXEjOw/uUq77bvk3J07t
	ICIsBtPedy7m8T5oz1SN0PQR2/OgedZnqmfmXdMpUb4y7MpD08OY04k/dMZnt4pahMb3djmtNeE
	RbNognfs4WQ9SHEJaXMifWj1h5c8=
X-Google-Smtp-Source: AGHT+IE68mWPrj8nhNuwhdBTZDW+/PhBliP6ZlYVn0gmb/ZzESVIUaoYHMt+xNGiGfbr3Q21axU0LJ/XLzBOrdxIaxo=
X-Received: by 2002:a17:90b:ec8:b0:2c2:cee8:bd6e with SMTP id
 98e67ed59e1d1-2c2cee8c23emr8492707a91.49.1718093801440; Tue, 11 Jun 2024
 01:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024061137-jawless-dipped-e789@gregkh>
In-Reply-To: <2024061137-jawless-dipped-e789@gregkh>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 11 Jun 2024 17:16:30 +0900
Message-ID: <CAMZ6Rq+rS=LO2EL7Mzurdsv3LVMmiJ3C9a9yEsdMJeqBaRbLMg@mail.gmail.com>
Subject: Re: [PATCH v2] .editorconfig: remove trim_trailing_whitespace option
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Danny Lin <danny@kdrag0n.dev>, 
	=?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue. 11 juin 2024 at 16:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Some editors (like the vim variants), when seeing "trim_whitespace"
> decide to do just that for all of the whitespace in the file you are
> saving, even if it is not on a line that you have modified.  This plays
> havoc with diffs and is NOT something that should be intended.
>
> As the "only trim whitespace on modified files" is not part of the
> editorconfig standard yet, just delete these lines from the
> .editorconfig file so that we don't end up with diffs that are
> automatically rejected by maintainers for containing things they
> shouldn't.
>
> Cc: Danny Lin <danny@kdrag0n.dev>
> Cc: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Fixes: 5a602de99797 ("Add .editorconfig file for basic formatting")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, this v2 is way better!

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
> v2: - only remove the lines, don't move the whole file to Documentation
>     - add Fixes: tag
>
>
>  .editorconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/.editorconfig b/.editorconfig
> index 854773350cc5..29a30ccfc07b 100644
> --- a/.editorconfig
> +++ b/.editorconfig
> @@ -5,7 +5,6 @@ root =3D true
>  [{*.{awk,c,dts,dtsi,dtso,h,mk,s,S},Kconfig,Makefile,Makefile.*}]
>  charset =3D utf-8
>  end_of_line =3D lf
> -trim_trailing_whitespace =3D true
>  insert_final_newline =3D true
>  indent_style =3D tab
>  indent_size =3D 8
> @@ -13,7 +12,6 @@ indent_size =3D 8
>  [*.{json,py,rs}]
>  charset =3D utf-8
>  end_of_line =3D lf
> -trim_trailing_whitespace =3D true
>  insert_final_newline =3D true
>  indent_style =3D space
>  indent_size =3D 4
> @@ -26,7 +24,6 @@ indent_size =3D 8
>  [*.yaml]
>  charset =3D utf-8
>  end_of_line =3D lf
> -trim_trailing_whitespace =3D unset
>  insert_final_newline =3D true
>  indent_style =3D space
>  indent_size =3D 2
> --
> 2.45.2
>

