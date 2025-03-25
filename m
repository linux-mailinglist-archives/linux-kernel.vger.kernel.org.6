Return-Path: <linux-kernel+bounces-575395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA742A70234
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5093BFFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B82676D0;
	Tue, 25 Mar 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MnvFuj61"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961B25D52E;
	Tue, 25 Mar 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908383; cv=pass; b=SsvnElaeR0CnDWbfLMxvs0Svr+SycFNWH7WVOkAIu7vsRs71ZVk6qw8SvTRNfZ9eS+sT8KwuBgOv4ZIxuOOta8I0epGwR1gb2vkpN6nWnBYGg1x8ZhV8XN3kNHON/NHpCcP5F9WZGVk/nN8nvnbakkA8J3qA92A/2q4XTSnptDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908383; c=relaxed/simple;
	bh=XKlX6iqRU46yL85G+dbu84MIS9b/QnIIvCk1gZah01o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AFe+TgRAoGOIG7oT0e9i0Nw7sgNOLidr1Pi1K9CpwceXJ753T7cSnies3CzaU1YFogjkt+7eI28vFskKoUqYBlv9XhgMpqAErekCCni+3nKWCD+FULKRNodsXE8u0uM4W+O6mN3JgdixTnbr36t2J5t7LdzQHG+eW3Isg58gUxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=MnvFuj61; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742908353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z+VDrG8LN4a/SSZIxGGcnWeHuOAMvZ5KTehw2L0iZmLMT1RR7CGWOicbVjFuXjMmLqrUEFHTRI0V8isaCfZKOEAHdBdWqmspkRxv3txIhx+jmRAwT50GKive8qGPazZEjj3QSvfHkCrKKsH34xDOS0b9jKKqDO0IezGKCLuxNdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742908353; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U1DzXkzGwrt00tzTeYfRiOBq9nYPvYNpn2edXH0c3to=; 
	b=TC4Xru1hcD8VEmOLBksGNVJr8z8IWDInbaD3IEF2E1qJgYCRAzMvfmGb6EFBHaDiVtSRZYtvMM1D2NPDuQ2BB56GmU21d6f0rJX7WLkewgaPVJDTrWtnajs+H72ZHlnaP/RaXGYOq+seg+lWp6v62XLfiNiFpQ5VWw8x0iGTVg8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742908353;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=U1DzXkzGwrt00tzTeYfRiOBq9nYPvYNpn2edXH0c3to=;
	b=MnvFuj61a71BUKF6oB9kGQjqlFxTrjAdPWNEP57GpZ09BsFOHdIsdj510AQDQt7u
	pumqImFZIZf7rqUAUwGK3R0GR/kVa06rGnxV3J1UViUT28s2vjoiJOuRCfW1hOJ+Qfg
	YGbx4kaRQl/Z5IK5mZ+4/WBMLasciGoip1THRKMs=
Received: by mx.zohomail.com with SMTPS id 1742908351023174.43653162229032;
	Tue, 25 Mar 2025 06:12:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 03/11] scripts: generate_rust_analyzer.py: add trailing
 comma
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-3-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 10:12:15 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Boris-Chengbiao Zhou <bobo1239@web.de>,
 Kees Cook <kees@kernel.org>,
 Fiona Behrens <me@kloenk.dev>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47AA0C4B-AE6C-422F-9C32-1ED2B0FAE3E5@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-3-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Add missing trailing comma on multi-line function call as suggested by
> PEP-8:
>=20
>> The pattern is to put each value (etc.) on a line by itself, always
>> adding a trailing comma, and add the close parenthesis/bracket/brace
>> on the next line.
>=20
> This change was made by a code formatting tool.
>=20
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index e2bc4a717f87..e997d923268d 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -180,7 +180,7 @@ def main():
>=20
>     logging.basicConfig(
>         format=3D"[%(asctime)s] [%(levelname)s] %(message)s",
> -        level=3Dlogging.INFO if args.verbose else logging.WARNING
> +        level=3Dlogging.INFO if args.verbose else logging.WARNING,
>     )
>=20
>     # Making sure that the `sysroot` and `sysroot_src` belong to the =
same toolchain.
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

