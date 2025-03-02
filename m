Return-Path: <linux-kernel+bounces-540316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E04A4AFDA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9C7AB7F7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523B82253B2;
	Sun,  2 Mar 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rljYv7Fu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A18222594;
	Sun,  2 Mar 2025 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898211; cv=none; b=VsL+OUg/R6D5F2Js9olO+6qXAwbVf9NOEeORqH7GXE9RQk9fwefm5q8H5O0h5eYpHc8c1ALUr9kvUnRqc4EVFuSEF7xoRyR+nDfwH5dB/TDVC4QCi2AvD6klEwSDrWwXKSGexHUOTsne3b8EaozZg5WIhiVE+DEYSFDwaB62yu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898211; c=relaxed/simple;
	bh=fRzbSestC72BknEy98C8wapiwmRnJyoLyRuCn42wXtw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mX4aazMD9b6QkRN7C5CYP9CWxhx8X4aojPMoJr1lb40OdaZyTSEkB/CP8CNSoFL7NsAYB8nDiSdtdTOGJkv7Obu4/D76P853d4tTRQ7zwWS4Ca5+XzadhNzlcc7sy0nW44grLiLLGHEB2RBAhG7FCGTkGnnr345NaDr1SZXA4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rljYv7Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D53C4CED6;
	Sun,  2 Mar 2025 06:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740898211;
	bh=fRzbSestC72BknEy98C8wapiwmRnJyoLyRuCn42wXtw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rljYv7Fuc8OCRqmu47SYvOI9GLcoqbN+BfYRnL78AzIlFP4mQqHSPHWxyy93SNzic
	 YnCmGe50B3iaWixssM8sRWWHADx88YWxn1aytb2v9J3ZNp/0JFkJVMbnAHABKhoejO
	 ovB2nSaY8aXNqzmRzdcl1sPeM+V8UBumM5W+Zfy8nCcXJmXwKL7LVVcA0jzPUMinEC
	 WeBCv0MBZ6hmjZuMORVV/xdM8RjW1LCCZipTSFuKeApII3bVmCMI62yg1Esmzsdi0N
	 2RHDqhZLPA2l+D9ptof5sFVn+6vVvNOwPXgjEPMjHf3qj6c8yFgbYoJ8g36PGDGDNn
	 a978+dEPNcXkA==
Date: Sat, 01 Mar 2025 22:50:06 -0800
From: Kees Cook <kees@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>, uecker@tugraz.at,
 dan.carpenter@linaro.org
CC: airlied@gmail.com, boqun.feng@gmail.com, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Rust kernel policy
User-Agent: K-9 Mail for Android
In-Reply-To: <20250301132229.3115698-1-safinaskar@zohomail.com>
References: <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at> <20250301132229.3115698-1-safinaskar@zohomail.com>
Message-ID: <68D70981-9BEE-4286-8D91-330E91EEA79F@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 1, 2025 5:22:29 AM PST, Askar Safin <safinaskar@zohomail=2Ecom> w=
rote:
>Hi, Martin Uecker and Dan Carpenter=2E
>
>> No, this absolutely is useful=2E  This is what UBSan does now
>
>> BTW: Another option I am investigating it to have UBsan insert traps
>> into the code and then have the compiler emit a warning only when
>
>Clang sanitizers should not be enabled in production=2E
>See https://www=2Eopenwall=2Ecom/lists/oss-security/2016/02/17/9 for deta=
ils

This is about ASan, in userspace, from almost a decade ago=2E Kernel UBSan=
 and HW-KASan are used in production for a long time now=2E Take a look at =
Android and Chrome OS kernels since almost 5 years ago=2E Ubuntu and Fedora=
 use the bounds sanitizer by default too=2E *Not* using the bounds sanitize=
r in production would be the mistake at this point=2E :)

-Kees

--=20
Kees Cook

