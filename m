Return-Path: <linux-kernel+bounces-575393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5FA7023F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA87A842F30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D82673A4;
	Tue, 25 Mar 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MQhif9Jl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790219CC2E;
	Tue, 25 Mar 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908307; cv=pass; b=RUzgHqRPU9lSq7S5gCrBkQkjFG1nMzrQkIFATjakEyEGu3VoaO9TMmexi8IVKTH5b3XkJXluuUB3o6MVWIrcL6c4gu+n00Cy/dPnMJDv75k/mWy9slL9+rc2KwYKkKGO4Fl93nNJJXS7Rep/oNqeX1pid+JCS3qOm8JYSR0ku3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908307; c=relaxed/simple;
	bh=F3M4xRxxZEd+MRvQ08oFk7oomJXKkj01N6u8v1bq4jo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=arx7FWE++O1jwWgFX4ghBVbmcH2LgfLR66KIjrWNC/0spFcwML4B9keworN73A/cpcEIejAwwgHDVz5mHKp4hRo0LwYGf5GxwdjWhN2lXisVrlLq/mPkJVdt6mhYYMZZFX79LetzO9U1umVTAt/hbFy5EU+EAgzWXJy74LeAXT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=MQhif9Jl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742908281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JZ09NcLU3ofT2BNR5EJp3KYd5fjx/j8yfk7iWngBkKEUqzDXKsvESJJTuc9bjDvxMpIk80rgg0EXWgyi+bEh7YTCRO1KnquUSNGd6PrNllE08DXq8l4ZJZkC3bNyGnXzUGSwmYGw9sb3YKUifl7O5ZlfWLDK0G4aCQU1qWHUHYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742908281; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=twnitO21dTvErIVWBhavTOZMN8TCo8oZ5guh8coyjqM=; 
	b=hSPifjSLRiYN9JrK6Uyiz5Ms7XtAgtJGBOK6FeG6S4HWgb30OMBv5V5WbePeRcu/eNU1qoS6oQ1y0+zqRIUC/TRIaN96MkJ28TovnBhD4rI+z3C4kWJfO4DdhgMVDgH2tzhAEMaodVGeqzptxlPkirqzkT4EhsjSaZjEj7lnrT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742908281;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=twnitO21dTvErIVWBhavTOZMN8TCo8oZ5guh8coyjqM=;
	b=MQhif9JlmnTF2D4+T/ob/K8fwiG3WxpGO+2GoV3fWcjR4pNV6Aw1Ice7BfElxHZ2
	31chhA5CAl5nHz7F6uuJ4fqxEeK+/cFtgki1OJmrr+vRjY/IaXUh0Zi6Ygc5SZs/oMy
	JduJ8dQkVkt9A6M19WO7RIKsTVxp6K9skbfzrKxk=
Received: by mx.zohomail.com with SMTPS id 1742908279441540.0955049314723;
	Tue, 25 Mar 2025 06:11:19 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 02/11] scripts: generate_rust_analyzer.py: use double
 quotes
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-2-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 10:11:03 -0300
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
Message-Id: <0C1AEBA2-A84F-4C15-9A74-F50A0CC74C22@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-2-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Replace inconsistent use of single quotes with double quotes.
>=20
> This change was made by a code formatting tool.
>=20
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index fc1788764b31..e2bc4a717f87 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -169,8 +169,8 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>=20
> def main():
>     parser =3D argparse.ArgumentParser()
> -    parser.add_argument('--verbose', '-v', action=3D'store_true')
> -    parser.add_argument('--cfgs', action=3D'append', default=3D[])
> +    parser.add_argument("--verbose", "-v", action=3D"store_true")
> +    parser.add_argument("--cfgs", action=3D"append", default=3D[])
>     parser.add_argument("srctree", type=3Dpathlib.Path)
>     parser.add_argument("objtree", type=3Dpathlib.Path)
>     parser.add_argument("sysroot", type=3Dpathlib.Path)
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

