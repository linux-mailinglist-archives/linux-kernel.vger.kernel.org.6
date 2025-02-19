Return-Path: <linux-kernel+bounces-522129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE754A3C65F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984CD3AB947
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9E21423E;
	Wed, 19 Feb 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFojkRAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFC1FE469;
	Wed, 19 Feb 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986802; cv=none; b=KtgKotReftNjm3gwsQs+1iRjlckEWX/AhN03aeRwpWhJvzfhv9cbLiweRzY0b1T/VkM2D7SyN2x1Lc3NKEIlhEh2DLTkUsjv5OqAb0vs6RNUZ1T8GN706+l8NEXK+9RkZKQ8svKEfRA4sQX6VftoHZLfj+Y6hSnhuyq4sjKVqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986802; c=relaxed/simple;
	bh=BrOiPMswomWJ6XqsINjW8va56UxLttek/R0SaLkDJy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idFnX6x1TqA0d2Yu0Soj9rGzW5/9eBucnFYXBeFdrWTKWsM7Zwiw48scb6Zqb/WX/fU81sO3lLdWVVC4NYc451QC9X7Cc+5Tijs3MCctywBH+a02F54zQuBhvM223g+XoD2viV1lYEYR/zErmeOTm88EFVWHDn91sTO+XsqN5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFojkRAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0149EC4CED1;
	Wed, 19 Feb 2025 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986801;
	bh=BrOiPMswomWJ6XqsINjW8va56UxLttek/R0SaLkDJy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFojkRAE3PsCM1Zdl4floaeqDvn+dqG2ftOOM+qWurxvOO9Kb207VzPB/oAq0bUXg
	 ykrLHwMp3h577PaGrXlx23VYDkyiFo38Y/hHYbJzCPp3jMoHV76RcS0cVUnkHxWoua
	 LI/Q7UanOvy8XrQsn6hKi1Rh6Omr5fFwlpXZDLB8CL0RRBHrrxABkHne3Qlil6v69U
	 I9ZP4LHo4Dx1x0FsPzmPBIrwuc7UmmPxaAAUdJ6sKgn/D+Xi1/0za595fHdBpghE2X
	 7k1J7LXnS8YoBB2LuUB626t7i72b32eJq/CPPQrOLtS0SutmYrd8+qOpBAo3AA6+sM
	 Qk/F1Sm4FEmZg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: remove non-existent dac from jh7110
Date: Wed, 19 Feb 2025 17:39:54 +0000
Message-ID: <20250219-uranium-agony-58a183616687@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213-tidy-dollop-cbfc8fc7dc91@spud>
References: <20250213-tidy-dollop-cbfc8fc7dc91@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=571; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=EfQa5Cbf8E10CaCu8nORwnfQGYXOH47Zlq27WaTHLZg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOnbxLOl/5nvOrF26fbzqmfuL13IOn2/9IpvV9uuO9rJ7 J655tnqox2lLAxiHAyyYoosibf7WqTW/3HZ4dzzFmYOKxPIEAYuTgGYCPsURoZp3d2ZbyYq/dM8 lTBBaf2mWSe/Kb1eLmu2Unx7dd5lk96zjAyNrleVpqa8d81cZ7JXmH/l0q7Ib1LWR41iNRznKR0 /b84HAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 13 Feb 2025 20:03:52 +0000, Conor Dooley wrote:
> The jh7110 boards do not have a Rohm DAC on them as far as I
> can tell, and they certainly do not have a dh2228fv, as this device does
> not actually exist! Remove the dac nodes from the devicetrees as it is
> not acceptable to pretend to have a device on a board in order to bind
> the spidev driver in Linux.
> 
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: remove non-existent dac from jh7110
      https://git.kernel.org/conor/c/4bdea6e33946

Thanks,
Conor.

