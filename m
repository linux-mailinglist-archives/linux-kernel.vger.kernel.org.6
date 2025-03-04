Return-Path: <linux-kernel+bounces-545254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99FA4EADB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E1A17B475
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4C27C87D;
	Tue,  4 Mar 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKIm+8gq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5827209F57;
	Tue,  4 Mar 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110528; cv=none; b=lv5QYyCGbbz9djG/kCzpAZuBIv2mZ9t6RGkMJuTjj8qPd/gpD/tXp4ZBsjO+ZOwxPEW8tTAK9wSZM+WqBavbpj3nzc6olq5jLN7yeFewqfajlIodCZxNQuxG6KK6cCFD1uDogT0ZPijUtM7loLNE6t9t1mmJ55NAvAxTZUaG9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110528; c=relaxed/simple;
	bh=ev0z99uVBne2zit/zIk55GPh3D478gskiWyAFFzpyro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbqX3wNDV3+qT7251SmRcW5soMCQjlPJGI1Idz5kp9N+VTW5cPWiV8+8TYaBt+ZMJOq+9dEfwUc4ySVOnmd6JTVfiLEMYmg3dVpWj64fkfGNtI2SjAxIbxB7YNTcBYgtcKOTe/5zZ7dgoF4lG5W8FarQAS87md2voZiZydeRm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKIm+8gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E5EC4CEE8;
	Tue,  4 Mar 2025 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110527;
	bh=ev0z99uVBne2zit/zIk55GPh3D478gskiWyAFFzpyro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKIm+8gq9l4mHJY8OKVIFmeJ/GiYZBCioty0FDdvxsdnhpVxBIkk49wZL+0BG4Mxt
	 AwttCLI+rn60QtRHAYr49jixca7pzgi75CHwVeECrGB79otgRZKh55rUC2sshsSKtB
	 7spgo582vYvzhLQz1qP6OCo/6AYdGpG8xTqT03XH5yZam/aj/4CENDhvLDRmZDyKuP
	 rOXXaImY8DNCp269awZQEtpCkCocBP1wSBF6gWXSDtU6PaY+bdw+/v7XjaQX8Z0JMF
	 loz6guSdG3nsC+aDwb/bqBGj47oTPgK7ujyEg0pdsF11czAQHxA8dZwerzqMHwIyFH
	 Jfyi8DTl/uErQ==
Date: Tue, 4 Mar 2025 19:48:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Fiona Behrens <me@kloenk.dev>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z8c8-q1jMDm3t-OL@kernel.org>
References: <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook>
 <20250219202751.GA42073@nvidia.com>
 <20250219154610.30dc6223@gandalf.local.home>
 <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
 <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
 <87pljc6d7s.fsf@kloenk.dev>
 <Z7c3PguDn-sEl3gm@kernel.org>
 <m2cyexjb8d.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2cyexjb8d.fsf@kloenk.dev>

On Tue, Mar 04, 2025 at 12:17:54PM +0100, Fiona Behrens wrote:
> I do have a new pr open in the nix repo, it still needs some polishing
> and gcc and all that. but it does work for me to build using clang and
> also run kunit.
> 
> https://github.com/Rust-for-Linux/nix/pull/8

My scenario has no connection to this. Let me explain.

I needed a system comparable to BuildRoot and Yocto to build images and
manage complexity of two toolchains. I.e. I use it only as build system
not as an environment for doing kernel development.

I.e. what I created is

https://gitlab.com/jarkkojs/linux-tpmdd-nixos

which replaces eventually

https://codeberg.org/jarkko/linux-tpmdd-test

What I can do with my environment is essentially along the lines of

1. docker compose up --build
2. qemu-system-x86_64 -M pc -m 2G -drive if=pflash,format=raw,unit=0,file=output/firmware.fd -drive file=output/tpmdd-nixos.qcow2,if=virtio,format=qcow2 -nographic

I use this in Fedora Linux where I do all my kernel development. This
is something I plan to update to MAINTAINERS as a test environment.

> 
> Thanks
> Fiona
> 

BR, Jarkko

