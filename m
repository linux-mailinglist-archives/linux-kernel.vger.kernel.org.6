Return-Path: <linux-kernel+bounces-513318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657BA34905
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6013AE983
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F121CDA3F;
	Thu, 13 Feb 2025 16:01:32 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C5201271
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462491; cv=none; b=L1T8CozsTAb21vF/f7oP7FRo9KrEuQ3Xva95eAJJNCGY9Vrv+2EvOjeO7JilziLCR99lI3i0g0XcY1uDmbjTqzVVipYZurRHdwLq2k3RJHc3F4LQhWbvi/lyN02rIXJOM3XSi61EJ0+Gn3r2fK/Ry4d3/PMlRqch4hAxfSbOFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462491; c=relaxed/simple;
	bh=nRz2yzSITsxRQzMh5EL9FOw5VJMeF8SAQBWYANCbNsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taCw29RhSRZJGUZw0S52gxms85t3EDPwvcYlOe4lWKRkIxKvgG9BcLw6Eg8X0bPhu/dzjisMJ6boceqxKreCsXakaUz5mjJ72LZaXgusVKOrKqYjVa9ocn0S+8AUVBEwvXbGQz+/jEZYWkVaKdFYMxg8xz5ZEsNCRLfReZV88L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51DG137D005145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 11:01:05 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A7BEF15C000A; Thu, 13 Feb 2025 11:01:03 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: corbet@lwn.net, adilger.kernel@dilger.ca, jack@suse.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, dennis.lamerice@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Minor cleanups to ext4 and jbd2
Date: Thu, 13 Feb 2025 11:00:55 -0500
Message-ID: <173946232426.399068.7156785933165072414.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
References: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 18 Dec 2024 22:54:11 +0800, Kemeng Shi wrote:
> v1->v2:
> -Collect RVB from Yi
> -Properly remove t_private_list from document.
> 
> Patch 1 remove unused ext4 journal callback
> patch 2 remove transaction->t_private_list which is only used by ext4
> journal callback
> Patch 3 remove unneeded forward declaration of
> ext4_destroy_lazyinit_thread().
> 
> [...]

Applied, thanks!

[1/3] ext4: remove unused ext4 journal callback
      commit: fa1008e3df6220368b8ea3b004eca501ed546973
[2/3] jbd2: remove unused transaction->t_private_list
      commit: 06b9e91425b26b5e782f82a043a3f6c6354947c2
[3/3] ext4: remove unneeded forward declaration
      commit: 5e22ff3bc9358f994e65c870e2c4a8002ba81791

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

