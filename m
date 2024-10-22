Return-Path: <linux-kernel+bounces-375769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F69A9A89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CC1F22C39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4FD148FE6;
	Tue, 22 Oct 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPXSACyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0E13AD0;
	Tue, 22 Oct 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581061; cv=none; b=CilL0/vb/Si5+/F0OtJaoFDoWd91VZirVV9qT5JLcKFQkQVoYSUQtnVH/lZK5NnzUKnGfBWG0D3oT5sMto3lNzW0DClFYOlcATuvV5EyPkc8cP6JiJPxYbBwPazuAwVaCZ8s9PkwdHW6hGSpBn0/QuHtaRZulJo9sYSiCGHENo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581061; c=relaxed/simple;
	bh=vb+cU60c7MdvWOBp8UCzVJYuxWyGW719y/z+ys8ZW+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubbxkPJJqMhgsZo4hWPWaQJVxVMMycTPNf0ya9ZPgQxOr+DcQJWJuDxMjBX3CuWCxGvL6pmP2KsyXgYEYYpu8cPyXEOoC5Ifj+KWLvk5rhoW60L1aT3rI9F8C7GnW4j63oX3pJ3bi1CSoLo9j8GkVCAfm4Bdb6S9GXSxjDKYhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPXSACyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167A6C4CEC3;
	Tue, 22 Oct 2024 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729581060;
	bh=vb+cU60c7MdvWOBp8UCzVJYuxWyGW719y/z+ys8ZW+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPXSACyqlp3+ZuaK9KrTewNpZ8QIdRylwtVUo5kKRIYICqxO+REQKw0jepd+WpKw0
	 ltxuNU4l8YWMoAIf9oDvahADt86JwWzJFikUpm1N2EC/Fas3wx5bw6+OFIus0w2lBH
	 1foZI7UKIM6sXu1S7S5yRh7b8vhBgpJrWticwWso=
Date: Tue, 22 Oct 2024 09:10:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tony Chung <tony467913@gmail.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: mos7840: Add more kinds of baud rate
Message-ID: <2024102207-unmixed-caregiver-b9eb@gregkh>
References: <20241022070127.66083-1-tony467913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022070127.66083-1-tony467913@gmail.com>

On Tue, Oct 22, 2024 at 03:01:28PM +0800, Tony Chung wrote:
> This patch adds more kinds of baud rate support.
> also fix all the coding style errors & warnings shown by /scripts/checkpatch.pl

Hint, when you say "also" in a patch changelog, that's a huge hint you
should split this up into multiple changes.

Remember, each patch should do only one logical thing.  Do not mix bug
fixes or new features or coding style changes in the same commit.

thanks,

greg k-h

