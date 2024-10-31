Return-Path: <linux-kernel+bounces-389759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D816B9B70D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0401F21F92
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19B3D6A;
	Thu, 31 Oct 2024 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLxIo+Dp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D123A9;
	Thu, 31 Oct 2024 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332988; cv=none; b=s0Jir0qP5eZo2h+lCVrtZbj/nLc9U6a/eUFCiE7MejPY9JdiZNQ7AhUVkiOc6BsFtKtqposSO+sOJmK839aufkTwcXnS+T/bm+VjcJfw76gOsYgqW2kfWVmmej4fb1kIpcRnlHJLC9ockY23heb01XMrNX8mv11/UHj6V/JDbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332988; c=relaxed/simple;
	bh=CikwB/NrQnzTildOznPfkOjL6oOkxT3+G4YQT0qeZRI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=rq6X+EM8CL4HF+NPAM5Dzz5fivHnDkz8sobczFuwQ2lCBURgrGRgbe6Wce9RTCpzYyctNThcKIk0IusQ4FQ4fIZnYm5drCqPOafFzsW1zoveVPKsBkZmlCbzCXAOEVNoG5GmY0uWtl+BXxg6gsJ0mJ8lTMrjCUzVTchfW/S+WpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLxIo+Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A61CC4CECE;
	Thu, 31 Oct 2024 00:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730332988;
	bh=CikwB/NrQnzTildOznPfkOjL6oOkxT3+G4YQT0qeZRI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=NLxIo+DpSSnW9OBIl9NeZHOUFuU1xSKFpCGbwFMwmkADoTzWYyJM6yo2yxJ3pn0MD
	 q81tkzty3nJKy1yQqP0jX4FjuwRgItyHunBgRypEP28J8iPHNVB7RI4FqHo9KjpPdt
	 YCCr5B6DipnsAhwzpIfdIHaDlEnJMdrsvLHUgfABUVvJVplJ8K8yvHTgsPTwF49NcB
	 yEkqdNfXjn+63fbN7DpTu+bx194Eb/3Iy/4v8MpFf5wBwNnFnFyvOHnijvW7sFP6wB
	 KfrUAyc/+pX6269PgRIag1H8NXSYqw1O9WrcoGWxwWCWgM8wTGCHn6fcvzmB89/UlY
	 1atB+PI+o47Zw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 02:03:03 +0200
Message-Id: <D59JUMVCDKC8.2ML39QBA5R5MG@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux@treblig.org>,
 <dhowells@redhat.com>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: Remove unused asymmetric_keys functions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241022002434.302518-1-linux@treblig.org>
 <D54YPO281JW8.SC38DUD3YEQX@kernel.org>
In-Reply-To: <D54YPO281JW8.SC38DUD3YEQX@kernel.org>

On Fri Oct 25, 2024 at 5:38 PM EEST, Jarkko Sakkinen wrote:
> On Tue Oct 22, 2024 at 3:24 AM EEST, linux wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > encrypt_blob(), decrypt_blob() and create_signature() were some of the
> > functions added in 2018 by
> > commit 5a30771832aa ("KEYS: Provide missing asymmetric key subops for n=
ew
> > key type ops [ver #2]")
> > however, they've not been used.
> >
> > Remove them.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> LGTM, thanks.
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Herbert, would you mind picking this up for you future crypto PR? I took
by "mistake/reflex" to my master unintentionally.

BR, Jarkko

