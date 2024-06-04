Return-Path: <linux-kernel+bounces-201132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C768FB9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CE31F2724C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247814A0A7;
	Tue,  4 Jun 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyxXfWtu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406F149E1E;
	Tue,  4 Jun 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520794; cv=none; b=RtWGmwCkjOX71wqvF6ar2u44J6+FcE/XDYWir6fRYScqV+ChqtepQ22X7phKFraUaTCGiU+lNAZAP8oSjHE2fFV1nDpaLo2XyvdYnkhm5Tp9uu4gr8gw18PCqgXQXendAnQN9cnpLNwk19IaHZ8CsKaKPEqk6r3KRMPlYVbnWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520794; c=relaxed/simple;
	bh=tUBl/sGlfXdb3mfB5sq1boTwBro77b8hrFoMIHiFHAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyrJl7lSOFaHkqFIOQlX2N8zr5N/I5J1q93mA113W1nJObB7Hq3RRLupjHsngyj1kwQa7im39PAH+FICaHItJxXvI+db8c9G3Pei+ZIJcpayWujPfIFbrsLTYyYbXXg7BoFpvZq+yUv6QvSBPsp7c2F9A7BcJkhaYKfjW3rh7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyxXfWtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29427C2BBFC;
	Tue,  4 Jun 2024 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520794;
	bh=tUBl/sGlfXdb3mfB5sq1boTwBro77b8hrFoMIHiFHAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyxXfWtuHQltY7Xz1Wn0BdmlNCBdh+qCbBJhLPTyY7aFsljjtCGs2psPeNyTcDWS9
	 FNNnecaiXxl0W8pro08xWEFCXy11vz3aByIjYZiQtCi3OyctiXcnb6Tlp1CIdxbqpU
	 h0kS6PLrQFLSDIqraxZr4me42JwQNew6QjtQ1y82IiOaOENmKgqJRAGNAfZJPZst2v
	 oc43+S6G0pUwIis4rd88gWHLJEkabc+LfkNcYaj4XI54mloqh+VJCIseQBQHCd0VoB
	 fnTeB1Oq36tLG1Xjre/JqopFSawco6DJAXUIzydgh7qfoJJ709yCxWezlYvy7vB0Tp
	 cJ75sB8TQeOUw==
From: Conor Dooley <conor@kernel.org>
To: kernel@esmil.dk,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org,
	aou@eecs.berkeley.edu,
	duwe@suse.de,
	linux-kernel@vger.kernel.org,
	palmer@dabbelt.com,
	heinrich.schuchardt@canonical.com,
	paul.walmsley@sifive.com,
	linux-riscv@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: Update flash partition layout
Date: Tue,  4 Jun 2024 18:06:22 +0100
Message-ID: <20240604-exes-reuse-4e71199a2aab@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603150759.9643-1-matthias.bgg@kernel.org>
References: <20240603150759.9643-1-matthias.bgg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=369; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4+UQ1S3fvbCY3fO8QuWvBZzXb5ymXFVsbruVFqi2CM8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnxnn1nlnScPrf25LrpGbkva644ms687fpzWm/XnNDpW b/WVmiodpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiJ94x/K/sPeSbsedIWVTu KzWufO7GKdv+i8zkesLEK/OgpX9jqiDDX7nCSA0ep+6t0e8jJue+2q4dejHhy2xLe7dQhhtyb0q EOAE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 03 Jun 2024 17:07:55 +0200, matthias.bgg@kernel.org wrote:
> Up to now, the describe flash partition layout has some gaps.
> Use the whole flash chip by getting rid of the gaps.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: Update flash partition layout
      https://git.kernel.org/conor/c/1dc5f8f6ea73

Thanks,
Conor.

