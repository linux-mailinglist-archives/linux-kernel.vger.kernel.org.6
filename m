Return-Path: <linux-kernel+bounces-406274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D49C5CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C5F2845B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93420408E;
	Tue, 12 Nov 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYKIv+Jo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728320409D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427358; cv=none; b=TGxZspDVQQmUmrioaHanQ7qo8PIRKyJ2SprrD0jaM81g7GRADDrJZ44BriyMnC+LCMiN8ZYorrgBlaqlo7L8dCsunHI/OSxteOoAcyNDFWpRyyozovoChQOWzvYMBPsYF8jBdt+FFwWA52a7GLfH46W62xvUXfbhUXFfead1Khg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427358; c=relaxed/simple;
	bh=efFI8RXNB5yk4oDmT4ANreFO9ztbxGjMLhSdvdUrxnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/a3AMuLczk4xF0wPnSrW+hHeffxZAgZqvt0KfrJsyKrViTf3P0sDl7ns9yd17W2BHqtEVngm1YeLigi0LdQ+KdIi2C093k0+uV6Tm/h7xcpgxrH90KpsWdZBWQIRFcQv/w2WfV3ZJPzMqJd+SMKel1TujmgQOqpt9SliX+PWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYKIv+Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A2AC4CECD;
	Tue, 12 Nov 2024 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731427357;
	bh=efFI8RXNB5yk4oDmT4ANreFO9ztbxGjMLhSdvdUrxnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYKIv+JoX9TRtzPkchuonV4Lwaq+Qb6w+s2XxHTudaMHO2ldH+WhQinfJo7Gn5WTw
	 b3+pnXgrl84uzt/H6q8vmXstjOzlvhnsNw7fS8C3PxcV0+n6Uu3UppYhjsrzd5Gb47
	 KJRPfKicEzeHc9ZUxl9+wPckG0qLkNr1Opf4blbwvnhthYbBZqrWxLT+/aefONT67A
	 MxHuNyyDQXlDCoKmAqRdOOmzJDDlc5Q7Zf82k/7emyhKhzjvYYjBTWvlbqMjQSMZZi
	 K0eOPfo5AWpVaKtfKgI1P30CsHiF7TBUS3IsddFI0OI0KGCmIuFiWMISuq7kGUHrvz
	 KyEiKgVwUyczA==
Date: Tue, 12 Nov 2024 08:02:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: davem@davemloft.net, pabeni@redhat.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH] ynl: samples: Fix the wrong format specifier
Message-ID: <20241112080236.092f5578@kernel.org>
In-Reply-To: <20241112083921.283923-1-luoyifan@cmss.chinamobile.com>
References: <20241112083921.283923-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 16:39:21 +0800 Luo Yifan wrote:
> Make a minor change to eliminate a static checker warning. The type
> of s->ifc is unsigned int, so the correct format specifier should be
> %u instead of %d.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Please repost and CC the netdev@ mailing list

