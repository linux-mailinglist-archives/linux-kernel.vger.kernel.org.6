Return-Path: <linux-kernel+bounces-556707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB802A5CDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE373A402A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EBD262D20;
	Tue, 11 Mar 2025 18:21:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751F78F5D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717261; cv=none; b=R2ho5uw+SInNMFBJ58r7VZXWY+4iU/EQGMET8QZqlxK/qwC21Al/0PnBeEKLx4xL/dxv/KJihGmejf/XWhWa2KA7rsKY2juneHvX9yd70dE+hMDL9e1cq9VGLY/3/Qs6rUovbkYc+IO0ntuauQje6lZzlFKwMFMG5zmo/wt7QD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717261; c=relaxed/simple;
	bh=9/lxu0cPDdRd0qP0yqkSacCPiZMMWrbjDYPz48QpZoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acREEfpVLngHmxFtmVjb0ynf/mYkW87swY2U50CljTwYasmIlBmt5yqOrHGUiFakd37zNU+i/ikDma6EvWQ79QStwKMK1fhGvXwu1Rplc3lZcaAfkJ9P5ThM6vZ9ibmRLe8SMVatc8VG2fsBnkTZTe3Y9MSP/r4Nc7ih3ksC3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F8EC4CEE9;
	Tue, 11 Mar 2025 18:21:00 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Yue Haibing <yuehaibing@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64/fpsimd: Remove unused declaration fpsimd_kvm_prepare()
Date: Tue, 11 Mar 2025 18:20:58 +0000
Message-Id: <174171719963.3723629.1526900223897615698.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250309070723.1390958-1-yuehaibing@huawei.com>
References: <20250309070723.1390958-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 09 Mar 2025 15:07:23 +0800, Yue Haibing wrote:
> Commit fbc7e61195e2 ("KVM: arm64: Unconditionally save+flush host
> FPSIMD/SVE/SME state") removed the implementation but leave declaration.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/fpsimd: Remove unused declaration fpsimd_kvm_prepare()
      https://git.kernel.org/arm64/c/31208bad3937

-- 
Catalin


