Return-Path: <linux-kernel+bounces-227767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D97915654
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201BB1C2242C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB01A2570;
	Mon, 24 Jun 2024 18:12:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2881A01C3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252757; cv=none; b=mnDdu6Da4z+tRyI6HMB91DBHgTcwFchvhcqA9uN8YHazDCqmnBMxLI+NhiLDFU4eEJ9txJBKy8BeuPf4ZVFUVYXeH9b7Q++0QUyQLEW/6vdupW0lwl0ZF5XBeJ74b7gZJjMMxAxBjNnz3yyKRMthj4RzjHovjozJU+AiJOty4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252757; c=relaxed/simple;
	bh=BlESWvqzVc257cEnCHixJCT/48coL+LIvYQsQ+yWQO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0ipr4fpaQe9hDh/bg4pTXi78N3WlOE4JNbqlWBhkguZUYH1h7EjUsfCUJvnyxJhEZG/A5BiEJaz08qHUr0mktWJGTtR5Myg4wNSex32k8YvCckV9MmT+uV5P+AOQ+Qmn0zoIgUqmAhxEXOdQeABEbQ0fdcMQRIYLyd8JZ97YEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF09C2BBFC;
	Mon, 24 Jun 2024 18:12:35 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig: fix typo in __builtin_return_adddress
Date: Mon, 24 Jun 2024 19:12:33 +0100
Message-Id: <171925273631.3100383.13807173936308688488.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620174038.3721466-1-rppt@kernel.org>
References: <20240620174038.3721466-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 20:40:38 +0300, Mike Rapoport wrote:
> Comment about BUILTIN_RETURN_ADDRESS_STRIPS_PAC spells
> __builtin_return_adddress with a triple 'd', fix it.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Kconfig: fix typo in __builtin_return_adddress
      https://git.kernel.org/arm64/c/cf63fe35f1ef

-- 
Catalin


