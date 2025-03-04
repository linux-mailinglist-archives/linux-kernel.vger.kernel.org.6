Return-Path: <linux-kernel+bounces-545523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5502A4EE27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7203A7177
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13825FA09;
	Tue,  4 Mar 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLsm/bUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFA1FA243;
	Tue,  4 Mar 2025 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119293; cv=none; b=Eve2Tf/7h+W8i01sQJzDgaxKEhRSG1AvHIOLr4pz+PMLZORwODQmsSrXRZMus3b4McS4oGcl7XToJkv+NA6QSeCVygOnv/LSuVf8ao9Tlsi+jnzsE4II1t7BR6Ma4Wr8JJISLfDOQDz0qUauSu8FfhNBMULay7BzPjPTr8M0fpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119293; c=relaxed/simple;
	bh=/SdYLvXLxxIr6edsKxmHtDYVasPB2NFy7RBgCPOacpc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SILih+8KHVb27tNoYa9xl6YnwRKPYYxjsTTJ47N9ReBfOiSTkw0KzOTygtDxCBCoOW66wLvhIjgEmza0UICFzo4tgPWD/F52DUCfWYHLzEGZQw1B65l6bI2NcfvG9LoZZ/8cCCoXi1Li5ox3KIseGLQqtkb73diuqBK480UTeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLsm/bUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3A3C4CEE5;
	Tue,  4 Mar 2025 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741119293;
	bh=/SdYLvXLxxIr6edsKxmHtDYVasPB2NFy7RBgCPOacpc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QLsm/bUbgYtZ4Smh3LmXG741wWsRjlcDu/nvmBl9dkVABrEM1myVTfKiyv9fcuBO4
	 AFYGzh1Lq3TkXnG5TEDpJ4F94P7MO9UzJz2xQx3gTdokdX4Cwl3ygoufalKPtxU1H5
	 h4/Lg4ubu3jrO8/f5Zp8qzDEkSaWNit7tvUTEfGKhJdIsO1VTlnGmZknZAEIvGjQVA
	 +W8nmZgkC5IpLg8TxH7i14Q4E9+yTSfRFzDm5EcICGRjmUTnMyX007u70uaCCEidk1
	 /m0rOXFBlsFbys5VktXghpcZw3H/4LtRGtiSheBJgNNnw9fS/djwmIpA13LLN8nuGN
	 DbAn1OQF/q4Xg==
Date: Tue, 4 Mar 2025 21:14:50 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: silence unreachable code warning
In-Reply-To: <4585c11a-3e85-4f26-b1e1-0aad5e05706d@stanley.mountain>
Message-ID: <4r6151p3-6q5p-1915-64o3-oo505p6674qp@xreary.bet>
References: <4585c11a-3e85-4f26-b1e1-0aad5e05706d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Feb 2025, Dan Carpenter wrote:

> In theory, this code used to return 0 if CONFIG_ACPI_PLATFORM_PROFILE was
> disabled.  It's not clear if that was a config which would actually boot
> so we've removed the CONFIG_ACPI_PLATFORM_PROFILE ifdef.  But now the
> "return 0;" statement is unreachable and static checker tools complain.
> 
> Delete it and pull the else statement in a tab to silence the checker
> warning and make the code a bit more clear.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied, thanks Dan.

-- 
Jiri Kosina
SUSE Labs


