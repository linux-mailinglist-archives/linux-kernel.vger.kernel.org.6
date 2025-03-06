Return-Path: <linux-kernel+bounces-549920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F0EA55898
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ECDC7A3B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D8209F4A;
	Thu,  6 Mar 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cazu6oZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C82063EB;
	Thu,  6 Mar 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295987; cv=none; b=qBAR0U8YUHwVWUwZ8YFKDDHKldK9bTJ+kORZ8XqFvDDr0aF1TDatdBaZOKOgLpLwgA+h37MFp19Qt3riecJ4JGDmiW/xzx229OhwCcw7o5RYSgpzH5HCQpf088uJE10HiLOU1ZvNmY3pn7K2wKRQ3zD2cW2VtvWjoAZOcF6zE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295987; c=relaxed/simple;
	bh=XN+Ey8cN+SJIk7PE+4pqJFYo0whimSQnIOpxKW/DKdw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE3Zo7tG8QTVFm7gGq7Kxjk3+4ErwhWT3eaYlLSfLOk5K+CaHvNIkmK0Aw3aeCkt/TCK2kJ30BPkARIithiDZPH7ZzoLqIk8XzuH2DuRyKSTAkY5FpKbdYE3droXUXiBu9bNREnetHEr7LsD2htdm2il+jRq/b2Zy7YijAvU9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cazu6oZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECBFC4CEE0;
	Thu,  6 Mar 2025 21:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741295986;
	bh=XN+Ey8cN+SJIk7PE+4pqJFYo0whimSQnIOpxKW/DKdw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Cazu6oZrueuAszhrUC1ohuFyYKDBKqjTUXYTUXHorYtVZ4CYAiCXdXymEbO3vcFN/
	 Cpusw0oPO7Sorpy3YvArHIL3A47IRBNm3z0S5LZokXtSXhxILIiLg3WquDBjS2cLFz
	 oIG0MucqtsezoCRPWxrhDbB/gt7YeeXuL1Oa6zYB9Obp8M1MV6yUdEfNlxsChA7mYp
	 XDDSLnrRG8YPQoLHslB0o3C533Pg8b1UvFfy4eZGGB4qORZoM6srBYiCI+I0eKWsBo
	 7y7JTGfBuLvwLkqyacLHPGHMKv+5zwYKe54B7oird30/CN/qfbmHL4NwDoY5jrfuSV
	 wQSNK0iuJLgEQ==
Date: Thu, 6 Mar 2025 23:19:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: linux-tpmdd-nixos
Message-ID: <Z8oRbtw8NDPkSLDF@kernel.org>
References: <20250306211716.51120-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306211716.51120-1-jarkko@kernel.org>

On Thu, Mar 06, 2025 at 11:17:16PM +0200, Jarkko Sakkinen wrote:
> This is my new testing tree for my kernel tree. It will over time replace
> my previous BuildRoot based testing tree (but not just yet).
> 
> Depending on host `docker compose up --build` (or podman) will spit out
> rootfs and OVMF/AAVMF image depending on host where it is compiled.

Oops "depending on host" x2. As far as I'm concerned don't care ;-)

BR, Jarkko

